#!/usr/bin/env zsh
# ═══════════════════════════════════════════════════
# PLUGIN MANAGER
# ═══════════════════════════════════════════════════
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# ═══════════════════════════════════════════════════
# PLUGINS
# ═══════════════════════════════════════════════════
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# ═══════════════════════════════════════════════════
# COMPLETIONS
# ═══════════════════════════════════════════════════
# Only run expensive security check once per 24 hours
autoload -Uz compinit                                    # Load the compinit function
if [[ -n ${ZSH_COMPDUMP}(#qN.mh+24) ]]; then             # If dump file is >24 hours old
  compinit -d "${ZSH_COMPDUMP}"                          # Full initialization (slow)
else                                                     # If dump file is fresh
  compinit -C -d "${ZSH_COMPDUMP}"                       # Skip security check (fast)
fi
zinit cdreplay -q
