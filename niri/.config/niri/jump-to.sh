#!/bin/sh
# Niri script to jump to first instance of application
# USAGE: Mod+Alt+F { spawn "focus-app.sh firefox"; }

# inputs
JUMP_TO_APP=$1

# find the window id of the first instance of program
WINDOW_ID=$(niri msg -j windows | jq -r ".[] | select(.app_id==\"$JUMP_TO_APP\") | .id" | head -n1)
if [ -n "$WINDOW_ID" ]; then
  # found focus on that window
  niri msg action focus-window --id "$WINDOW_ID"
fi
