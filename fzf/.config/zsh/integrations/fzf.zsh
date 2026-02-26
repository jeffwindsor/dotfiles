#!/usr/bin/env zsh
# FZF - Fuzzy finder
if command -v fzf &> /dev/null; then
  eval "$(fzf --zsh)"
fi
