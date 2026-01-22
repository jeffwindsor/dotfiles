#!/usr/bin/env zsh
nvim-by-appname() {
  local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt=" " --height=~50% --layout=reverse --border --exit-0)
  [[ -z $config ]] && echo "No config selected" && return
  NVIM_APPNAME=$(basename $config) nvim $@
}

alias v='nvim'
alias v.='nvim .'
alias vl='NVIM_APPNAME=nvim-lazy nvim'
alias vl.='NVIM_APPNAME=nvim-lazy nvim .'
alias vm='NVIM_APPNAME=nvim-mini nvim'
alias vm.='NVIM_APPNAME=nvim-mini nvim .'
alias vv='nvim-by-appname'
alias vv.='nvim-by-appname .'

alias md='cd ~/markdown/'
alias mde='cd ~/markdown/ && nvim'
