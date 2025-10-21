
alias z = zellij 
alias zc = zellij --layout claude
alias zd = zellij --layout dev
alias zl = zellij ls


# kill all but current sessions
def zkill [] {
  zellij list-sessions --no-formatting
  | lines
  | where not ($it | str contains "current")
  | each { |line| ($line | split row " " | get 0) }
  | each { |session| zellij kill-session $session }
}
# delete all exited sessions
def zdelete [] {
  zellij list-sessions --no-formatting
  | lines
  | where ($it | str contains "EXITED")
  | each { |line| ($line | split row " " | get 0) }
  | each { |session| zellij delete-session $session }
}

zdelete
