#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "$0")/common.sh"

require_macos() {
  [ "$(uname -s)" = Darwin ] || die "this script is for macOS"
}

require_command_line_tools() {
  if xcode-select -p >/dev/null 2>&1; then
    info "Command Line Tools found"
    return
  fi
  xcode-select --install >/dev/null 2>&1 || true
  die "Command Line Tools missing. Finish the install, then run ./install.sh again."
}

print_next_steps() {
  info "Done. Next:"
  info "  open Ghostty"
  info "  run nvim once, plugins and tools install on first launch"
}

main() {
  require_macos
  require_non_root
  require_command_line_tools
  install_homebrew_if_missing
  install_brewfile_packages
  link_dotfiles_with_stow
  print_next_steps
}

main
