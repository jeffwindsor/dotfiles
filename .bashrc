#!/usr/bin/env bash

# shell independent envs
if test -f "$HOME/.envrc"; then
  source "$HOME/.envrc"
fi

# Enables displaying colors in the terminal
export TERM=xterm-color
export EDITOR="$(which nvim)"

# shell independent aliases
if test -f "$HOME/.aliasrc"; then
  source "$HOME/.aliasrc"
fi

# fuzzy finder: https://github.com/junegunn/fzf
if command -v fzf &>/dev/null; then
  eval "$(fzf --bash)"
fi

# z-oxide: cd replacement
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init bash)"
fi

# starship prompt
if command -v starship &>/dev/null; then
  eval "$(starship init bash)"
fi
