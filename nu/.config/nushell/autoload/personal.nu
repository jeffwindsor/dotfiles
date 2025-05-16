#!/usr/bin/env nu

$env.XDG_STATE_HOME = ($env.HOME | path join ".local/state")
$env.XDG_DATA_HOME = ($env.HOME | path join ".local/share")
$env.XDG_CACHE_HOME = ($env.HOME | path join ".cache")
$env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
alias config = cdl $env.XDG_CONFIG_HOME 



# navigation
alias "....." = cd ../../../../
alias "...." = cd ../../../
alias "..." = cd ../../
alias ".." = cd ..

# list
alias c = clear
alias cc = cdl $env.HOME
alias la = ls -a
alias ll = ls -l
alias lla = ls -la

# `sh` crutches
alias cat = open
alias fg = job unfreeze
alias jobs = job list
alias a = scope aliases

def ar [query] {
  scope aliases
  | where {|r| $r.expansion =~ $query or $r.name =~ $query}
}

def af [query] {
  scope commands
  | where command_type == "custom"
  | where name =~ $query
  | select name params 
}
