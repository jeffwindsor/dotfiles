#!/usr/bin/env zsh
# Load user modules (sourced in order alphabetically)

for f in "$XDG_CONFIG_HOME/zsh/user-modules"/*.zsh; do
  [[ -f "$f" ]] && source "$f"
done

setopt extended_glob

function sync(){
  for func in ${(ok)functions}; do
      if [[ $func == sync-* ]]; then
          echo "Running sync $func..."
          $func
      fi
  done
}
