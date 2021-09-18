#!/usr/bin/env zsh

for rc in $XDG_CONFIG_HOME/zsh/*
do
    source $rc
done
