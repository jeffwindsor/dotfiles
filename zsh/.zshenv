#!/usr/bin/env zsh
#
export XDG_STATE_HOME=$HOME/.local/state
export XDG_DATA_HOME=$HOME/.local/share

export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config

for rc in $XDG_CONFIG_HOME/env/*
do
    source $rc
done
