# Shared by macos.sh and linux.sh. Must stay compatible with macOS's bash 3.2.

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STOW_PACKAGES="shell config tmux gitconfig"
BACKUP_DIR="$HOME/.lazyconfig-backup/$(date +%Y%m%d-%H%M%S)"
BACKUP_COUNT=0

info() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33mwarn:\033[0m %s\n' "$*" >&2; }
die() {
  printf '\033[1;31merror:\033[0m %s\n' "$*" >&2
  exit 1
}

require_non_root() {
  [ "$(id -u)" -ne 0 ] || die "run as your user, not root"
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
  if load_homebrew_env; then
    info "Homebrew found at $(brew --prefix)"
    return
  fi
  info "Installing Homebrew (asks for your password once)"
  # NONINTERACTIVE can't prompt for a password, so cache sudo first.
  sudo -v
  NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  load_homebrew_env || die "Homebrew installed, but brew wasn't found"
}

install_brewfile_packages() {
  info "Installing packages from Brewfile"
  if ! brew bundle --file "$REPO_DIR/Brewfile"; then
    warn "some packages failed, see above. Fix them, then run ./install.sh again."
  fi
}

move_to_backup() {
  local relative_path="$1"
  mkdir -p "$BACKUP_DIR/$(dirname "$relative_path")"
  mv "$HOME/$relative_path" "$BACKUP_DIR/$relative_path"
  warn "moved ~/$relative_path to the backup dir"
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

link_dotfiles_with_stow() {
  # Without a real ~/.config, stow would make ~/.config itself a link into the repo.
  mkdir -p "$HOME/.config"
  local package
  for package in $STOW_PACKAGES; do
    backup_files_blocking_stow "$package"
    stow --dir "$REPO_DIR" --target "$HOME" --restow "$package"
    info "linked $package"
  done
  if [ "$BACKUP_COUNT" -gt 0 ]; then
    info "old files saved in $BACKUP_DIR"
  fi
}
