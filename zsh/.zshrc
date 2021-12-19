#!/usr/bin/env zsh

for rc in $XDG_CONFIG_HOME/zsh/*
do
    source $rc
done

for rc in $XDG_CONFIG_HOME/aliases/*
do
    source $rc
done
