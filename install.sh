#!/usr/bin/env bash
set -euo pipefail

# Stow every package in this repo into $HOME.
# Each directory mirrors the structure it should take relative to $HOME,
# e.g. ghostty/.config/ghostty/config -> ~/.config/ghostty/config.

PACKAGES=(claude equibop flow ghostty gitu nvim opencode pi)

cd "$(dirname "$0")"

if ! command -v stow >/dev/null 2>&1; then
  echo "error: GNU Stow is not installed (brew install stow)" >&2
  exit 1
fi

for pkg in "${PACKAGES[@]}"; do
  if [[ ! -d "$pkg" ]]; then
    echo "error: package '$pkg' is missing" >&2
    exit 1
  fi
  stow "$pkg"
  echo "stowed $pkg"
done

echo "All packages stowed."