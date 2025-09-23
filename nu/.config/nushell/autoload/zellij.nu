
alias z = zellij 
alias zc = zellij --layout claude
alias zd = zellij --layout dev
alias zl = zellij ls


# delete all exited sessions
def zdelete [] {
  zellij list-sessions --no-formatting
  | lines
  | where ($it | str contains "EXITED")
  | each { |line| ($line | split row " " | get 0) }
  | each { |session| zellij delete-session $session }
}
# alias zdelete = zellij list-sessions --no-formatting | grep "EXITED" | cut -d' ' -f1 | xargs -I {} zellij delete-session {}
