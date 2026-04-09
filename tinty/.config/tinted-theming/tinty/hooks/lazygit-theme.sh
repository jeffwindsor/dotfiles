#!/usr/bin/env bash
# Copies the lazygit theme file, falling back to the base16 equivalent when a
# base24 theme is applied (the repo only contains base16 themes).
# Accepts either a lazygit yml path or a tinted-shell script path.

set -euo pipefail

src="$1"

# If called with a tinted-shell script path, derive the lazygit yml path
if [[ "$src" == *.sh ]]; then
  theme_name=$(basename "$src" .sh)
  repos_dir=$(dirname "$(dirname "$src")")
  src="$repos_dir/base16-lazygit/colors/${theme_name}.yml"
fi

mkdir -p "${HOME}/.config/lazygit"

if [[ -f "$src" ]]; then
  cp -f "$src" "${HOME}/.config/lazygit/theme.yml"
else
  dir=$(dirname "$src")
  base=$(basename "$src")
  fallback="$dir/${base/base24-/base16-}"
  [[ -f "$fallback" ]] && cp -f "$fallback" "${HOME}/.config/lazygit/theme.yml"
fi
