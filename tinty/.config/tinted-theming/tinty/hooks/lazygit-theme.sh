#!/usr/bin/env bash
# Copies the lazygit theme file, falling back to the base16 equivalent when a
# base24 theme is applied (the repo only contains base16 themes).

set -euo pipefail

src="$1"
mkdir -p "${HOME}/.config/lazygit"

if [[ -f "$src" ]]; then
  cp -f "$src" "${HOME}/.config/lazygit/theme.yml"
else
  dir=$(dirname "$src")
  base=$(basename "$src")
  fallback="$dir/${base/base24-/base16-}"
  [[ -f "$fallback" ]] && cp -f "$fallback" "${HOME}/.config/lazygit/theme.yml"
fi
