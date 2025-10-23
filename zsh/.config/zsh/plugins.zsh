#!/usr/bin/env zsh
# plugins.zsh - Zinit plugin manager and plugins

# ═══════════════════════════════════════════════════
# ZINIT PLUGIN MANAGER
# ═══════════════════════════════════════════════════
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# ═══════════════════════════════════════════════════
# ZSH PLUGINS
# ═══════════════════════════════════════════════════
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# ═══════════════════════════════════════════════════
# LOAD COMPLETIONS
# ═══════════════════════════════════════════════════
# Only run expensive security check once per 24 hours
autoload -Uz compinit                                    # Load the compinit function
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then      # If dump file is >24 hours old
  compinit                                               # Full initialization (slow)
else                                                     # If dump file is fresh
  compinit -C                                            # Skip security check (fast)
fi

# Load fzf-tab AFTER compinit (it needs to override the completion system)
zinit light Aloxaf/fzf-tab

zinit cdreplay -q
