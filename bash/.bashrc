#!/usr/bin/env bash

# Enables displaying colors in the terminal
export TERM=xterm-color
export EDITOR="$(which hx)"
export VISUAL="$(which zed)"

source <(carapace _carapace)

# shared
if test -f "$HOME/.shellrc"; then
	source "$HOME/.shellrc" bash
fi
