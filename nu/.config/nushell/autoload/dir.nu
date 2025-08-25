
# Clear and list all
def l [] {
  clear
  ls -a
}

alias "....." = cd ../../../../
alias "...." = cd ../../../
alias "..." = cd ../../
alias ".." = cd ..
alias c = clear
alias cc = cdl $env.HOME false
alias la = ls -a
alias ll = ls -l
alias lla = ls -la
# jump to config directory
alias config = cdl $env.XDG_CONFIG_HOME
