# shellcheck shell=bash
# Shared by macos.sh and linux.sh. Must stay compatible with macOS's bash 3.2.

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOTFILE_PACKAGES="shell config tmux gitconfig"
BACKUP_DIR="$HOME/.lazyconfig-backup/$(date +%Y%m%d-%H%M%S)"
BACKUP_COUNT=0
BACKED_UP_PATHS=""
LINK_ONLY=0
STEP_SHOWN=0

header() { printf '\033[1mlazyconfig · %s\033[0m\n' "$*"; }
step() {
  STEP_SHOWN=1
  printf '\n\033[1;34m%s\033[0m\n' "$*"
}
ok() { printf '  \033[32m✓\033[0m %s\n' "$*"; }
skip() { printf '  \033[2m– %s\033[0m\n' "$*"; }
note() { printf '  \033[2m%s\033[0m\n' "$*"; }
warn() { printf '  \033[33m!\033[0m %s\n' "$*" >&2; }
die() {
  [ "$STEP_SHOWN" -eq 1 ] || step "Check"
  printf '  \033[31m✗\033[0m %s\n' "$*" >&2
  exit 1
}

install_mode() {
  if [ "$LINK_ONLY" -eq 1 ]; then
    echo "link only"
  else
    echo "full install"
  fi
}

home_relative() {
  echo "~${1#"$HOME"}"
}

parse_args() {
  local arg
  for arg in ${1+"$@"}; do
    # shellcheck disable=SC2034
    case "$arg" in
      --link-only) LINK_ONLY=1 ;;
      *) die "unknown option: $arg (only --link-only)" ;;
    esac
  done
}

require_non_root() {
  [ "$(id -u)" -ne 0 ] || die "run as a normal user, not root"
}

load_homebrew_env() {
  local brew_bin
  for brew_bin in \
    /opt/homebrew/bin/brew \
    /usr/local/bin/brew \
    /home/linuxbrew/.linuxbrew/bin/brew \
    "$HOME/.linuxbrew/bin/brew"; do
    if [ -x "$brew_bin" ]; then
      eval "$("$brew_bin" shellenv)"
      return 0
    fi
  done
  return 1
}

install_homebrew_if_missing() {
  step "Homebrew"
  if load_homebrew_env; then
    ok "found: $(brew --prefix)"
    return
  fi
  note "installing, asks for your password once"
  # NONINTERACTIVE can't prompt for a password, so cache sudo first.
  sudo -v || die "needs sudo. Without it, use --link-only."
  NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  load_homebrew_env || die "installed, but brew wasn't found"
  ok "installed: $(brew --prefix)"
}

install_brewfile_packages() {
  step "Packages"
  local brewfile="$REPO_DIR/Brewfile"
  if brew bundle check --no-upgrade --file "$brewfile" >/dev/null 2>&1; then
    ok "all Brewfile packages installed"
    return
  fi
  if brew bundle --no-upgrade --file "$brewfile"; then
    ok "Brewfile packages installed"
  else
    warn "some packages failed, see above. Fix them, then run ./install.sh again"
  fi
}

move_to_backup() {
  local relative_path="$1"
  mkdir -p "$BACKUP_DIR/$(dirname "$relative_path")"
  mv "$HOME/$relative_path" "$BACKUP_DIR/$relative_path"
  BACKED_UP_PATHS="$BACKED_UP_PATHS$relative_path
"
  BACKUP_COUNT=$((BACKUP_COUNT + 1))
}

points_into_repo() {
  local home_path="$1" repo_path="$2"
  [ "$(readlink -f "$HOME/$home_path")" = "$(readlink -f "$repo_path")" ]
}

first_symlinked_parent() {
  local relative_path="$1" parents prefix="" part
  parents="$(dirname "$relative_path")"
  [ "$parents" != . ] || return 1
  local IFS=/
  for part in $parents; do
    prefix="${prefix:+$prefix/}$part"
    if [ -L "$HOME/$prefix" ]; then
      echo "$prefix"
      return 0
    fi
  done
  return 1
}

backup_files_blocking_stow() {
  local package="$1" source_file relative_path linked_parent
  while IFS= read -r -d '' source_file; do
    relative_path="${source_file#"$REPO_DIR/$package/"}"
    if linked_parent="$(first_symlinked_parent "$relative_path")"; then
      points_into_repo "$linked_parent" "$REPO_DIR/$package/$linked_parent" ||
        move_to_backup "$linked_parent"
      continue
    fi
    [ -e "$HOME/$relative_path" ] || [ -L "$HOME/$relative_path" ] || continue
    points_into_repo "$relative_path" "$source_file" || move_to_backup "$relative_path"
  done < <(find "$REPO_DIR/$package" -type f -print0)
}

report_backups() {
  [ "$BACKUP_COUNT" -gt 0 ] || return 0
  local noun="files" path
  [ "$BACKUP_COUNT" -ne 1 ] || noun="file"
  warn "$BACKUP_COUNT $noun moved to $(home_relative "$BACKUP_DIR")"
  while IFS= read -r path; do
    if [ -n "$path" ]; then
      note "  $path"
    fi
  done <<EOF
$BACKED_UP_PATHS
EOF
}

link_dotfiles_with_stow() {
  # Without a real ~/.config, stow would make ~/.config itself a link into the repo.
  step "Dotfiles"
  mkdir -p "$HOME/.config"
  local package
  for package in $DOTFILE_PACKAGES; do
    backup_files_blocking_stow "$package"
    stow --dir "$REPO_DIR" --target "$HOME" --restow "$package"
  done
  report_backups
  ok "linked with stow: ${DOTFILE_PACKAGES// /, }"
}

relative_path_between() {
  local from_dir="$1" to_path="$2" up=""
  while [ "$from_dir" != / ] && [ "${to_path#"$from_dir"/}" = "$to_path" ]; do
    from_dir="$(dirname "$from_dir")"
    up="../$up"
  done
  if [ "$from_dir" = / ]; then
    echo "$up${to_path#/}"
  else
    echo "$up${to_path#"$from_dir"/}"
  fi
}

link_with_ln() {
  local source="$1" relative_path="$2" target_dir
  target_dir="$(cd "$HOME/$(dirname "$relative_path")" && pwd -P)"
  ln -s "$(relative_path_between "$target_dir" "$source")" "$HOME/$relative_path"
}

link_entry() {
  local source="$1" relative_path="$2" target="$HOME/$2"
  if [ -d "$source" ] && [ -d "$target" ] && [ ! -L "$target" ]; then
    link_folder_contents "$source" "$relative_path"
    return
  fi
  if [ -e "$target" ] || [ -L "$target" ]; then
    points_into_repo "$relative_path" "$source" && return
    move_to_backup "$relative_path"
  fi
  link_with_ln "$source" "$relative_path"
}

link_folder_contents() {
  local source_dir="$1" relative_dir="$2" source
  while IFS= read -r -d '' source; do
    link_entry "$source" "${relative_dir:+$relative_dir/}$(basename "$source")"
  done < <(find "$source_dir" -mindepth 1 -maxdepth 1 -print0)
}

link_dotfiles_with_ln() {
  step "Dotfiles"
  mkdir -p "$HOME/.config"
  local package
  for package in $DOTFILE_PACKAGES; do
    link_folder_contents "$(cd "$REPO_DIR/$package" && pwd -P)" ""
  done
  report_backups
  ok "linked with ln -s: ${DOTFILE_PACKAGES// /, }"
}

in_local_ghostty() {
  [ -n "${GHOSTTY_RESOURCES_DIR:-}" ] && [ -z "${SSH_CONNECTION:-}" ]
}

note_terminal_reload() {
  if in_local_ghostty; then
    note "restart Ghostty to load its config"
  else
    note "open a new terminal to load the new shell config"
  fi
}

note_tmux_reload() {
  if [ -n "${TMUX:-}" ]; then
    note "reload tmux: prefix r"
  fi
}

note_nvim_step() {
  if [ "$LINK_ONLY" -eq 1 ]; then
    note "nothing installed, nvim config needs 0.12+"
  else
    note "run nvim once: plugins and tools install, needs internet"
  fi
}
