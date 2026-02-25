#!/usr/bin/env zsh
# Zoxide 
if command -v zoxide &> /dev/null; then
 eval "$(zoxide init zsh --cmd cd)"
fi
