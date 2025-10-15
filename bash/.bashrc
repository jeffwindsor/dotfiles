#!/usr/bin/env bash

# Enables displaying colors in the terminal
export TERM=xterm-color
export EDITOR="$(which nvim)"
export VISUAL="$(which zed)"

source <(carapace _carapace)

# shared
if test -f "$HOME/.shellrc"; then
  source "$HOME/.shellrc" bash
fi

# Created by `pipx` on 2025-10-15 22:49:04
export PATH="$PATH:/Users/jefwinds/.local/bin"
