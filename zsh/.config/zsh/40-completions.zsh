#!/usr/bin/env zsh
# completions.zsh - Completion system styling

# ═══════════════════════════════════════════════════
# COMPLETION STYLING
# ═══════════════════════════════════════════════════
# Case-insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Colorize completion lists
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Disable default menu
zstyle ':completion:*' menu no

# FZF-tab previews
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
