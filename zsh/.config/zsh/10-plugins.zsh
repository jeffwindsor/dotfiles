#!/usr/bin/env zsh
# ZINIT
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

if [[ ! -d "$ZINIT_HOME" ]]; then
    mkdir -p "${ZINIT_HOME:h}"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

# COMPLETIONS: Must be loaded before compinit so its completion functions are added to $fpath.
zinit light zsh-users/zsh-completions
ZCOMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump"
autoload -Uz compinit
() {
    setopt local_options extended_glob

    if [[ -n ${ZCOMPDUMP}(#qN.mh+24) ]]; then
        compinit -d "$ZCOMPDUMP"
    else
        compinit -C -d "$ZCOMPDUMP"
    fi
}

# INTERACTIVE PLUGINS
zinit wait lucid for \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-syntax-highlighting
