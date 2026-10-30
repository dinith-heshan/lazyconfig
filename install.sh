#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="$(cd "$(dirname "$0")/install" && pwd)"

case "$(uname -s)" in
  Darwin) exec bash "$INSTALL_DIR/macos.sh" ;;
  Linux) exec bash "$INSTALL_DIR/linux.sh" "$@" ;;
  *)
    echo "unsupported OS: $(uname -s)" >&2
    exit 1
    ;;
esac
