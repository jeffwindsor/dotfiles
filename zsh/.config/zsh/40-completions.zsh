#!/usr/bin/env zsh
# completions.zsh - Completion system styling

# ═══════════════════════════════════════════════════
# COMPLETION STYLING
# ═══════════════════════════════════════════════════
# Case-insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Colorize completion lists
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zstyle ':completion:*' menu select
