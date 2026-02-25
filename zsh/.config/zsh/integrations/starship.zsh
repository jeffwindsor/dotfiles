#!/usr/bin/env zsh
# Starship - Shell prompt
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi
