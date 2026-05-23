#!/usr/bin/env zsh

pick-tv() {
  local tmpdir selected
  tmpdir=$(mktemp -d)

  # Write function definitions (one file per function, named by function name)
  typeset -f | awk -v dir="$tmpdir" '
    /^[a-zA-Z_][a-zA-Z0-9_.-]* \(\)/ { name=$1; file=dir "/" name }
    name { print > file }
    /^\}$/ { name=""  }
  '

  # Write alias names and definitions now, in the current shell where they exist
  alias | sed 's/=.*//' > "$tmpdir/_alias_names"
  alias > "$tmpdir/_alias_defs"

  selected=$(tv --no-sort \
    --source-command="{ cat '$tmpdir/_alias_names'; ls '$tmpdir' | grep -v '^_'; }" \
    --preview-command="grep '^{}=' '$tmpdir/_alias_defs' 2>/dev/null || cat '$tmpdir/{}' 2>/dev/null" \
    --input-prompt="Pick: ")
  rm -rf "$tmpdir"
  [[ -z "$selected" ]] && return 0
  print -z "$selected"
}

alias pick=pick-tv
