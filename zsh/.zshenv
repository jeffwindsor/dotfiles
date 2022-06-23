#!/usr/bin/env zsh
#
export XDG_STATE_HOME=$HOME/.local/state
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config

export ZDOTDIR=$HOME/.config/zsh
export HISTFILE=$XDG_CACHE_HOME/zsh/zsh_history   # put history to cache, seperating it from the other ZDOT files

for rc in $XDG_CONFIG_HOME/env/*
do
    source $rc
done
