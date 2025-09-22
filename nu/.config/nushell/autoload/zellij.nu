
alias z = zellij 
alias zc = zellij --layout claude
alias zd = zellij --layout dev

alias zl = zellij ls
alias zdelete = zellij list-sessions --no-formatting | grep "EXITED" | cut -d' ' -f1 | xargs -I {} zellij delete-session {}
