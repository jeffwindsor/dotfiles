#!/usr/bin/env nu

const brew_packages = [
  [machine_name,   type,     packages];
  
  [all_machines,   formulae, ["asdf" "bash" "carapace" "fzf" "git" "helix" "lazygit" "nushell" "ripgrep" "starship" "stow" "television" "yazi" "zsh"]]
  ["Midnight Air", formulae, []]
  ["WKMZTAFD6544", formulae, ["aws-cdk" "colima" "docker-buildx" "docker" "lazydocker" "lima" "maven"]]
  
  [all_machines,   cask,     ["claude" "firefox" "ghostty" "google-chrome" "jordanbaird-ice" "keepingyouawake" "nikitabobko/tap/aerospace" "zed"]]
  ["WKMZTAFD6544", cask,     ["intellij-idea" "slack" "tuple", "visual-studio-code"]]
  ["Midnight Air", cask,     ["balenaetcher" "chatgpt" "discord" "iina" "spotify" "transmission"]]
]

$env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/bin')
$env.HOMEBREW_PREFIX = "/opt/homebrew"
$env.HOMEBREW_CELLAR = "/opt/homebrew/Cellar"
$env.HOMEBREW_REPOSITORY = "/opt/homebrew"
$env.HOMEBREW_NO_AUTO_UPDATE = "1"
$env.HOMEBREW_NO_INSTALL_CLEANUP = "1"

alias bn = brew install
alias bi = brew info
alias bs = brew search
def bl [] {
  run-external "brew" "leaves" | print 
  run-external "brew" "list" "--casks" | print
}

#== SYNC FUNCTIONS
def brew-up [] {
  section "Upgrading Brews"
  run-external "brew" "upgrade" | print
}

def brew-clean [] {
  section "Remove Orphaned Brews"
  run-external "brew" "autoremove" | print
  section "Clean up Cellar"
  run-external "brew" "cleanup" | print
}

def brew-sync [] {
  brew-up
  #brew-sync
  brew-clean
}

def brews-required-for-machine [type] {
  let machine_name = (networksetup -getcomputername)
  $brew_packages
    | where {|r| $r.machine_name == all_machines or $r.machine_name == $machine_name}
    | where {|r| $r.type == $type}
    | get packages
    | flatten
}

def brews-installed-on-machine [type] {
  match $type {
    cask => (run-external "brew" "list" "--casks" "--full-name" | table),
    formulae => (run-external "brew" "leaves" | table)
  }
}

def brew-sync-cask [] {
  let a = (brews-required-for-machine cask)
  let b = (brews-installed-on-machine cask)
  $a | where {|p| $p in $b}  
}




# def brew-package-sync [type, command, skip, packages] {
#   section $"Brew Sync ($command)"
#   $packages
#   | par-each --keep-order {|pkg|
#     if (skip $pkg) { 
#       dimmed $" ($pkg)"
#     } else {
#       info $" ($pkg)" 
#       run-external "brew" $command "--quiet" $"--($type)" $pkg
#     }
#   }
# }

# def brew-sync [packages = $brew_packages, remove = false] {
#   let machine_formulaes = brews-for-machine $packages formulae
#   let installed_formulae = brew leaves
#   brew-exec-on-missing $command formulae $requested_packages $installed_formulae
# }

# def brew-exec-on-missing [command, type, required_packages, installed_packages] {
#   # if required package is not installed then brew install else skip
#   $required_packages
#     | par-each --keep-order {|pkg|
#       if ($pkg in $installed_packages) { 
#         dimmed $" ($pkg)"
#       } else {
#         info $" ($pkg)" 
#         run-external "brew" $command "--quiet" $"--($type)" $pkg
#       }
#     }
# }
