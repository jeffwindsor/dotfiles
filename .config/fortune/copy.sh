#!/usr/bin/env bash

# get all files with no extension in current directory
cd "$(dirname "$0")" || exit
shopt -s extglob

LOCATION=$(readlink $(which fortune) | sd "fortune$" "" | sd "\.\." "$HOMEBREW_PREFIX")

# echo "removing current fortune files"
# sudo rm -f $LOCATION/*

echo "copying source files"
# files with no extension
sudo cp -v -- !(*.*) $LOCATION/

echo "copying dat files"
sudo cp -v *.dat $LOCATION/
