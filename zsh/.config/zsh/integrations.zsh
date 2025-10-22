#!/usr/bin/env zsh
# integrations.zsh - External tool integrations

# ═══════════════════════════════════════════════════
# EXTERNAL INTEGRATIONS
# ═══════════════════════════════════════════════════

# FZF - Fuzzy finder
if command -v fzf &> /dev/null; then
  eval "$(fzf --zsh)"
fi

# Starship - Shell prompt
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# Mise - Runtime manager
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

# Zellij - Terminal multiplexer cleanup
if command -v zellij &> /dev/null; then
  zellij list-sessions --no-formatting 2>/dev/null | \
    grep "EXITED" | \
    awk '{print $1}' | \
    xargs -I {} zellij delete-session {} 2>/dev/null
fi
