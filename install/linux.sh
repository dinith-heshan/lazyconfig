#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=install/common.sh
source "$(dirname "$0")/common.sh"

PACKAGE_MANAGER=""
FONT_DIR="$HOME/.local/share/fonts/JetBrainsMonoNerdFont"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"

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

package_manager_name() {
  if [ "$PACKAGE_MANAGER" = apt-get ]; then
    echo apt
  else
    echo "$PACKAGE_MANAGER"
  fi
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
  ok "installed with $(package_manager_name): build tools, curl, git"
}

has_local_display() {
  [ -n "${DISPLAY:-}${WAYLAND_DISPLAY:-}" ] && [ -z "${SSH_CONNECTION:-}" ]
}

install_font_on_desktop() {
  step "Font"
  if ! has_local_display; then
    skip "skipped: no display, only needed where the terminal runs"
    return
  fi
  if [ -n "$(find "$FONT_DIR" -name '*.ttf' 2>/dev/null | head -1)" ]; then
    ok "found: JetBrainsMono Nerd Font"
    return
  fi
  mkdir -p "$FONT_DIR"
  if ! curl -fsSL "$FONT_URL" | tar -xJ -C "$FONT_DIR" 2>/dev/null; then
    rm -rf "$FONT_DIR"
    warn "download failed, run ./install.sh again later"
    return
  fi
  if command -v fc-cache >/dev/null 2>&1; then
    fc-cache -f "$FONT_DIR" >/dev/null
  fi
  ok "installed: JetBrainsMono Nerd Font"
}

print_next_steps() {
  step "Next"
  if [ "$LINK_ONLY" -eq 1 ]; then
    note "nothing installed, configs use the tools already on this machine"
  else
    note "run nvim once to install plugins and tools"
  fi
  if has_local_display && ! command -v ghostty >/dev/null 2>&1; then
    note "Ghostty (optional): https://ghostty.org/docs/install/binary"
  fi
  if ! command -v zsh >/dev/null 2>&1; then
    note "zsh (optional): $(distro_install_command) zsh && chsh -s \"\$(command -v zsh)\""
  elif [ "$(basename "${SHELL:-}")" != zsh ]; then
    note "zsh as default (optional): chsh -s \"$(command -v zsh)\""
  fi
}

link_only() {
  link_dotfiles_with_ln
  print_next_steps
}

full_install() {
  [ "$(id -u)" -ne 0 ] || die "Homebrew won't run as root. Run as a normal user, or use --link-only."
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
  if [ -n "$PACKAGE_MANAGER" ]; then
    header "Linux ($(package_manager_name)) · $(install_mode)"
  else
    header "Linux · $(install_mode)"
  fi
  if [ "$LINK_ONLY" -eq 1 ]; then
    link_only
  else
    full_install
  fi
}

main "$@"
