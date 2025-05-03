#!/bin/bash
#== yazi: https://github.com/sxyazi/yazi

# open yazi and shell change to the selected directory on exit
function yazi-change-dir() {
	local tmp
	tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd" || return
	fi
	rm -f -- "$tmp"
}

alias y="yazi"
alias yy="yazi-change-dir"



