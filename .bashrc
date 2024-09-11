#!/usr/bin/env bash

# Enables displaying colors in the terminal
export TERM=xterm-color
export EDITOR="$(which nvim)"

# shared
if test -f "$HOME/.shellrc"; then
  source "$HOME/.shellrc" bash
fi

# z-oxide: cd replacement
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init bash)"
fi
