#!/usr/bin/env bash

# Enables displaying colors in the terminal
export TERM=xterm-color


export XDG_STATE_HOME=$HOME/.local/state
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config

# personal
export SRC=$HOME/Source
export EDITOR="$(which nvim)"

# fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --ignore-file ~/.config/fdignore'
export FZF_DEFAULT_OPTS='--height 60% --info=inline'

# git
export GIT_LOG_PRETTY_FORMAT='%C(green)%h%C(reset) - %s%C(cyan) | %an%C(dim) | %ch%C(auto)%d%C(reset)'
# ripgrep
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"

# shell independent aliases
if test -f $HOME/.aliasrc; then
	source $HOME/.aliasrc
fi

# z-oxide: cd replacement
if command -v zoxide &>/dev/null; then
	eval "$(zoxide init bash)"
fi

# starship prompt
if command -v starship &>/dev/null; then
	eval "$(starship init bash)"
fi

