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
autoload -Uz compinit
() {
  setopt local_options extended_glob
  if [[ -n ${ZDOTDIR:-~}/.zcompdump(#qN.mh+24) ]]; then
    compinit
  else
    compinit -C
  fi
}
zinit cdreplay -q
