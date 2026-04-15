#!/usr/bin/env zsh
# Load user modules (sourced in order alphabetically)

for f in "$XDG_CONFIG_HOME/zsh/user-modules"/*.zsh; do
  [[ -f "$f" ]] && source "$f"
done
