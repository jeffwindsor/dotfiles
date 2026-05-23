#!/usr/bin/env zsh

pick-fzf() {
  local tmpdir selected
  tmpdir=$(mktemp -d)

  typeset -f | awk -v dir="$tmpdir" '
    /^[a-zA-Z_][a-zA-Z0-9_.-]* \(\)/ { name=$1; file=dir "/" name }
    name { print > file }
    /^\}$/ { name=""  }
  '

  selected=$(
    {
      alias | sed 's/=/\t/'
      ls "$tmpdir" | grep -v '^_' | sed 's/.*/&\t/'
    } | fzf \
      --prompt="Pick: " \
      --height=100% \
      --border \
      --delimiter='\t' \
      --preview="if [[ -f $tmpdir/{1} ]]; then cat $tmpdir/{1}; else echo {2}; fi" \
      --preview-window=right:60%:wrap
  )
  rm -rf "$tmpdir"
  [[ -z "$selected" ]] && return 0
  print -z "${selected%%	*}"
}
