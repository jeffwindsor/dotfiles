#!/bin/bash

#== ls replacement: https://github.com/eza-community/eza
alias la="eza -F --group-directories-first --git --all --no-user --no-permissions"
alias ll="eza -lF --group-directories-first --git --no-user --no-permissions"
alias lla="eza -lF --group-directories-first --git --all --no-user --no-permissions"
alias l="clear && lla --header"

function cd-clear-list(){
	# emulate clifm 
	/usr/bin/cd $1
	clear
	l
}
alias ccc="cd-clear-list"

alias tree="clear && eza --tree --git --all --ignore-glob=.git"
alias treed="eza --tree --git -D --all --ignore-glob=.git"
alias treea="eza --tree --git --all --follow-symlinks --ignore-glob=.git"


