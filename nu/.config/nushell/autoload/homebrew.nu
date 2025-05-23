#!/usr/bin/env nu

const brew_required_packages = [
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
  let fs = brews-installed-on-machine formulae
  let cs = brews-installed-on-machine cask
  $fs | append $cs | sort
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
  brew-sync-install cask
  brew-sync-install formulae
  brew-clean
}

def brews-required-for-machine [type] {
  let machine_name = (networksetup -getcomputername)
  $brew_required_packages
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

def brew-sync-install [type] {
  let installed = brews-installed-on-machine $type
  let required = brews-required-for-machine $type

  $required
  | where { |p| $p not-in $installed }
  | par-each {|p| run-external "brew" "install" "--quiet" $"--($type)" $p }
}

def brew-sync-remove [type] {
  let installed = brews-installed-on-machine $type
  let required = brews-required-for-machine $type

  $installed
  | where { |p| $p not-in $required }
  | par-each {|p| run-external "brew" "remove" "--quiet" $"--($type)" $p }
}
