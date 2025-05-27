# personal backward compatibility "needs"

$env.EDITOR = "hx"
$env.VISUAL = "zed"
$env.XDG_STATE_HOME = ($env.HOME | path join ".local/state")
$env.XDG_DATA_HOME = ($env.HOME | path join ".local/share")
$env.XDG_CACHE_HOME = ($env.HOME | path join ".cache")
$env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")

alias config = cdl $env.XDG_CONFIG_HOME
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
