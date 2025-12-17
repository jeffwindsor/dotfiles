#!/usr/bin/env zsh

ZSH_CONFIG_DIR="${DOTFILES}/zsh/.config/zsh"

# Load all modules in numbered order
for module in "${ZSH_CONFIG_DIR}"/*.zsh; do
  [[ -f "$module" ]] && source "$module"
done

