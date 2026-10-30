#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=install/common.sh
source "$(dirname "$0")/common.sh"

LINK_ONLY=0
PACKAGE_MANAGER=""
FONT_DIR="$HOME/.local/share/fonts/JetBrainsMonoNerdFont"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"

parse_args() {
  local arg
  for arg in "$@"; do
    case "$arg" in
      --link-only) LINK_ONLY=1 ;;
      *) die "unknown option: $arg (only --link-only)" ;;
    esac
  done
}

require_linux() {
  [ "$(uname -s)" = Linux ] || die "this script is for Linux"
}

detect_package_manager() {
  local manager
  for manager in apt-get dnf pacman; do
    if command -v "$manager" >/dev/null 2>&1; then
      PACKAGE_MANAGER="$manager"
      return
    fi
  done
}

as_root() {
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  else
    sudo "$@"
  fi
}

install_distro_packages() {
  case "$PACKAGE_MANAGER" in
    apt-get)
      as_root apt-get update -qq
      # Never stop to ask about changed config files; keep the existing ones.
      as_root env DEBIAN_FRONTEND=noninteractive apt-get install -y -qq \
        -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold "$@"
      ;;
    dnf) as_root dnf install -y -q "$@" ;;
    pacman) as_root pacman -S --needed --noconfirm "$@" ;;
  esac
}

distro_install_command() {
  local sudo_prefix="sudo "
  [ "$(id -u)" -ne 0 ] || sudo_prefix=""
  case "$PACKAGE_MANAGER" in
    apt-get) echo "${sudo_prefix}apt install" ;;
    dnf) echo "${sudo_prefix}dnf install" ;;
    pacman) echo "${sudo_prefix}pacman -S" ;;
    *) echo "install" ;;
  esac
}

install_homebrew_prerequisites() {
  step "System packages"
  case "$PACKAGE_MANAGER" in
    apt-get) install_distro_packages build-essential procps curl file git xz-utils ;;
    dnf) install_distro_packages gcc gcc-c++ make procps-ng curl file git xz ;;
    pacman) install_distro_packages base-devel procps-ng curl file git xz ;;
    *) die "no apt, dnf or pacman. Install gcc, make, curl, file, git, xz yourself, or use --link-only." ;;
  esac
  ok "compiler, git, curl installed with $PACKAGE_MANAGER"
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

# Relative links, like stow makes, so a later full install can take them over.
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
  ok "linked $DOTFILE_PACKAGES"
  if [ "$BACKUP_COUNT" -gt 0 ]; then
    note "old files saved in $BACKUP_DIR"
  fi
}

has_local_display() {
  [ -n "${DISPLAY:-}${WAYLAND_DISPLAY:-}" ] && [ -z "${SSH_CONNECTION:-}" ]
}

install_font_on_desktop() {
  step "Font"
  if ! has_local_display; then
    ok "skipped, no display (only needed where the terminal runs)"
    return
  fi
  if [ -d "$FONT_DIR" ]; then
    ok "JetBrainsMono Nerd Font found"
    return
  fi
  mkdir -p "$FONT_DIR"
  curl -fsSL "$FONT_URL" | tar -xJ -C "$FONT_DIR"
  if command -v fc-cache >/dev/null 2>&1; then
    fc-cache -f "$FONT_DIR" >/dev/null
  fi
  ok "JetBrainsMono Nerd Font installed"
}

print_next_steps() {
  step "Done"
  if has_local_display && ! command -v ghostty >/dev/null 2>&1; then
    note "Ghostty (optional): https://ghostty.org/docs/install/binary"
  fi
  if ! command -v zsh >/dev/null 2>&1; then
    note "zsh (optional): $(distro_install_command) zsh && chsh -s \"\$(command -v zsh)\""
  elif [ "$(basename "${SHELL:-}")" != zsh ]; then
    note "zsh as default (optional): chsh -s \"$(command -v zsh)\""
  fi
  [ "$LINK_ONLY" -eq 1 ] || note "run nvim once to install plugins and tools"
}

link_only() {
  link_dotfiles_with_ln
  print_next_steps
}

full_install() {
  [ "$(id -u)" -ne 0 ] || die "Homebrew won't run as root. Run as your user, or use --link-only."
  install_homebrew_prerequisites
  install_homebrew_if_missing
  install_brewfile_packages
  install_font_on_desktop
  link_dotfiles_with_stow
  print_next_steps
}

main() {
  parse_args "$@"
  require_linux
  detect_package_manager
  if [ "$LINK_ONLY" -eq 1 ]; then
    link_only
  else
    full_install
  fi
}

main "$@"
