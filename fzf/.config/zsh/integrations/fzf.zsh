#!/usr/bin/env zsh
# FZF - Fuzzy finder
if command -v fzf &> /dev/null; then
  eval "$(fzf --zsh)"
  export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --color=16"
fi
