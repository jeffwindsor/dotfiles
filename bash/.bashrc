#!/usr/bin/env bash

# Homebrew
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export TERM=xterm-color
export EDITOR="$(which nvim)"
export VISUAL="$(which zed)"
export PATH="$PATH:/Users/jefwinds/.local/bin"

# ═══════════════════════════════════════════════════
# ALIASES
# ═══════════════════════════════════════════════════

# Basic utilities
alias p='pwd | pbcopy'
alias cat='bat --plain'
alias find='fd'
alias grep='rg'

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias c='clear'
alias l='clear && lsd -1 --git'
alias ll='lsd -l --git'
alias lla='lsd -lA --git'
alias treea='lsd --tree --all'
alias tree='lsd --tree'

# Editors
alias v='nvim'
alias v.='nvim .'
alias h='hx'
alias h.='hx .'

# ═══════════════════════════════════════════════════
# EXTERNAL INTEGRATIONS
# ═══════════════════════════════════════════════════

# FZF - Fuzzy finder
if command -v fzf &>/dev/null; then
  eval "$(fzf --bash)"
fi

# Starship - Shell prompt
if command -v starship &>/dev/null; then
  eval "$(starship init bash)"
fi

# Mise - Runtime manager
if command -v mise &>/dev/null; then
  eval "$(mise activate bash)"
fi
