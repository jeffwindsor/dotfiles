#!/usr/bin/env zsh
#   integrations.zsh is for:
  # - Shell initialization/startup code - Things that hook into external tools during shell startup
  # - Temporary wrapper functions - The lazy-load functions remove themselves after first use
  # - One-time setup/activation - Like fzf --zsh, starship init zsh, mise activate zsh
  # - Shell-level integrations - Code that modifies shell behavior or environment

# FZF - Fuzzy finder
if command -v fzf &> /dev/null; then
  eval "$(fzf --zsh)"
fi

# Starship - Shell prompt
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# Mise - Runtime manager (hybrid: eager PATH, lazy hooks)
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

# CJ Engineering: awsenv
if command -v awsenv >/dev/null 2>&1 && command -v brew >/dev/null 2>&1; then
    local awsenv_init="$(brew --prefix awsenv)/share/awsenv/shell-init.bash"
    [ -f "$awsenv_init" ] && source "$awsenv_init"
fi
