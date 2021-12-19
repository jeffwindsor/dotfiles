#!/usr/bin/env zsh

export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

for rc in $XDG_CONFIG_HOME/env/*
do
    source $rc
done
