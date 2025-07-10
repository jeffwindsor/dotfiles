

# === NOTE: SYNC FUNCTION IS WHY ASDF, BREW AND DOT FUNCTIONS ARE NOT IN SEPARATE FILES ===
# === Might need to move to modules that import/source other modules in the future
# Synchronize packages and dotfiles
#
# Pulls dotfiles from repo
# Install any missing brews
# Install and set any asdf defined tools
# Stows dotfiles to home directory
def sync [] {
  cd $env.HOME
  let brewfile = $"($env.DOTFILES)/(networksetup -getcomputername).Brewfile"
  dot-pull
  brew-sync
  mise install
  dot-sync
}

# Homebrew: Upgrade all packages
def brew-up [] {
  section "Homebrews: Updating Database"
  run-external "brew" "update" | print
  section "Homebrews: Upgrading All Packages"
  run-external "brew" "upgrade" | print
}
# Homebrew: Autoremove and Cleanup
def brew-clean [] {
  section "Homebrews: Removing Orphaned Packages"
  run-external "brew" "autoremove" | print
  section "Homebrews: Cleaning Up Package Cache"
  run-external "brew" "cleanup" | print
}
# Homebrew: Upgrade, Sync Install and Clean
def brew-sync [] {
  let brewfile = ($env.DOTFILES) | path join "brew" ".config" "homebrew" (networksetup -getcomputername) "Brewfile"
  brew-up
  run-external "brew" "bundle" "install" $"--file=($brewfile)"
  brew-clean 
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
