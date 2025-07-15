

# === NOTE: SYNC FUNCTION IS WHY ASDF, BREW AND DOT FUNCTIONS ARE NOT IN SEPARATE FILES ===
# ===       Might need to move to modules that import/source other modules in the future

# Synchronize packages and dotfiles
def sync [] {
  dot-pull
  brew-sync
  mise-sync
  ai-sync 
  dot-sync
}

# Claude: Sync Preference Files
def ai-sync [] {
  section "AI: Syncing Claude"
  let	machine = networksetup -getcomputername
  let source =  $env.DOTFILES | path join "claude" ".config" "claude" $machine ".claude_preferences.md"
  let target = $env.HOME | path join ".claude_preferences.md"
  ln -s $source $target
}

# Mise: Sync Plugins and Versions
def mise-sync [] {
  section "Mise: Syncing Global"
  let	machine = (networksetup -getcomputername)
  let source = $env.DOTFILES | path join "mise" ".config" "mise" $machine "mise.local.toml"
  let target = $env.HOME | path join "mise.local.toml"
  ln -s $source $target
  
  # operating on home directory to trust newly linked file and have install come from global file
  cd $env.HOME
  mise trust
  mise install
  cd -
}

# Homebrew: Upgrade, Sync Install and Clean
def brew-sync [] {
  
  section "Homebrews: Updating Database"
  brew update
  
  section "Homebrews: Upgrading All Packages"
  brew upgrade

  section "Homebrew: Installing Bundle"
  let	machine = (networksetup -getcomputername)
  let brewfile = ($env.DOTFILES) | path join "brew" ".config" "homebrew" $machine "Brewfile"
  run-external "brew" "bundle" "install" $"--file=($brewfile)"

  section "Homebrews: Removing Orphaned Packages"
  brew autoremove
  
  section "Homebrews: Cleaning Up Package Cache"
  brew cleanup
}


# Dotfiles: Pulls latest dotfiles and requests apps to reload configs where possible
def dot-pull [] {
  section "Pulling Dotfiles"
  git -C $env.DOTFILES pull

  # nushell reload
  source $nu.config-path
  source $nu.env-path
  
  # reload app configs
  run-external "aerospace" "reload-config"
}
# Dotfiles: Sync dotfiles for package if application is installed, otherwise remove
def stow-package [package: string, source: string, target: string] {
  if (which $package | length) > 0 {
    run-external "stow" "-S" "--dir" $source "--target" $target $package
    colorize $package green
  } else {
    run-external "stow" "-D" "--dir" $source "--target" $target $package
    colorize $package dark_gray
  }
}
# Dotfiles: sync all available dotfiles
def dot-sync [] {
  section "Syncing Dotfiles"
  dimmed $"from ($env.DOTFILES)"
  dimmed $"to   ($env.HOME)"
  
  ls --short-names $env.DOTFILES
  | where type == dir
  | par-each {|d| stow-package $d.name $env.DOTFILES $env.HOME }
}
