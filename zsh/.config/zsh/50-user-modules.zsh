#!/usr/bin/env zsh
# Load user modules (sourced in order alphabetically)

for f in "$XDG_CONFIG_HOME/zsh/user-modules"/*.zsh; do
  [[ -f "$f" ]] && source "$f"
done

setopt extended_glob

function sync(){
  local dir=$(mktemp -d) pid failed=0
  local -a pids

  # order matters: brew installs the tools, dots links their configs
  (( $+functions[sync-brew] ))   && { sync-brew   || failed=1 }
  (( $+functions[sync-dots] ))   && { sync-dots   || failed=1 }
  (( $+functions[sync-fedora] )) && { sync-fedora || failed=1 }

  # slow and independent: run together, show output afterwards
  (( $+functions[sync-mise] ))  && { sync-mise  &>"$dir/mise.log"  & pids+=($!) }
  (( $+functions[sync-tinty] )) && { sync-tinty &>"$dir/tinty.log" & pids+=($!) }
  (( $+functions[sync-zinit] )) && { sync-zinit &>"$dir/zinit.log" & pids+=($!) }

  for pid in $pids; do wait $pid || failed=1; done
  cat "$dir"/*.log(N)
  rm -rf "$dir"
  return $failed
}
