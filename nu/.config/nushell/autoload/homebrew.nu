alias bn = brew install
alias bi = brew info
alias bs = brew search
alias bsd = brew search --desc
def bl [] {
  section "Brew Formulae"
  print (brew leaves | lines | sort)
  print ""
  section "Brew Casks"
  print (brew list --cask | lines | sort)
  print ""
  section "Mise Installed"
  mise ls 
    | lines 
    | skip 1 
    | split column -r '\s{2,}' tool version source requested
    | where tool != ""
}



