#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=install/common.sh
source "$(dirname "$0")/common.sh"

require_macos() {
  [ "$(uname -s)" = Darwin ] || die "this script is for macOS"
}

require_command_line_tools() {
  step "Command Line Tools"
  if xcode-select -p >/dev/null 2>&1; then
    ok "found"
    return
  fi
  xcode-select --install >/dev/null 2>&1 || true
  die "missing. Finish the install that opened, then run ./install.sh again."
}

print_next_steps() {
  step "Done"
  note "open Ghostty"
  note "run nvim once to install plugins and tools"
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
