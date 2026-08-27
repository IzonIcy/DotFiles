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

MODE="stow"
STOW_FLAGS=()
case "${1:-}" in
  --check)
    # Simulate only: report what would be linked and any conflicts, change nothing.
    MODE="check"
    STOW_FLAGS=("-n")
    ;;
  "")
    ;;
  *)
    echo "usage: $0 [--check]" >&2
    exit 1
    ;;
esac

failures=0
for pkg in "${PACKAGES[@]}"; do
  if [[ ! -d "$pkg" ]]; then
    echo "error: package '$pkg' is missing" >&2
    exit 1
  fi
  # ${VAR[@]+...} guards empty-array expansion: bash 3.2 treats
  # "${STOW_FLAGS[@]}" as unbound under set -u when the array is empty.
  if stow ${STOW_FLAGS[@]+"${STOW_FLAGS[@]}"} "$pkg"; then
    if [[ "$MODE" == "check" ]]; then
      echo "ok       $pkg"
    else
      echo "stowed   $pkg"
    fi
  else
    failures=$((failures + 1))
    echo "CONFLICT $pkg (existing files block stowing)"
  fi
done

if [[ "$MODE" == "check" ]]; then
  if (( failures > 0 )); then
    echo "$failures package(s) would conflict — resolve them before running without --check."
    exit 1
  fi
  echo "All packages can be stowed cleanly."
else
  echo "All packages stowed."
fi