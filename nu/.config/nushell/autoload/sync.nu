const f = "formulae"
const c = "cask"
const all = "all_machines"
const ma = "Midnight Air"
const mp = "WKMZTAFD6544"

# TODO: start to use bundles, some of which have machine names? or machine names can have bundles...
const brew_required_packages = [
  [machine_name, type, package];
  [$all, $f, ["asdf" "bat" "bash" "carapace" "eza" "fd" "fzf" "glow" "helix" "lazygit" "nushell" "ripgrep" "starship" "stow" "television" "yazi" "zsh"]]
  [$ma,  $f, ["clifm"]]
  [$mp,  $f, ["aws-cdk" "colima" "docker-buildx" "docker" "lazydocker" "maven"]]
  [$all, $c, ["claude" "firefox" "ghostty" "google-chrome" "font-jetbrains-mono-nerd-font" "keepingyouawake" "nikitabobko/tap/aerospace" "zed"]]
  [$mp,  $c, ["intellij-idea" "slack" "tuple", "visual-studio-code"]]
  [$ma,  $c, ["balenaetcher" "chatgpt" "discord" "iina" "spotify" "transmission"]]
]

const asdf_packages = [
  [ machine_name, plugin, version];
	[ $mp, "java", "corretto-21.0.7.6.1"]
	[ $mp, "maven", "3.9.9"]
	[ $mp, "scala", "2.12.18"]
	[ $mp, "nodejs" "20.19.1"]
	[ $mp, "awscli", "2.27.0"]
]

# === NOTE: SYNC FUNCTION IS WHY ASDF, BREW AND DOT FUNCTIONS ARE NOT IN SEPARATE FILES ===
# === Might need to move to modules that import/source other modules in the future
# Synchronize packages and dotfiles
#
# Pulls dotfiles from repo
# Install any missing brews
# Install and set any asdf defined tools
# Stows dotfiles to home directory
def sync [] {
  dot-sync
  brew-sync 
  asdf-sync
  dot-stow
}

# sync install and set plugin versions
#
# Given table of [ machine_name, plugin_name, version ]
# To force install onto the local machine without providing the machine name
# Use "all_machines" in the first column 
# example:
# [
#   [ "all_machines", "java", "corretto-21.0.7.6.1"]
#   [ "myworklaptop", "scala", "2.12.18"]
# ]
def asdf-sync [packages = $asdf_packages] {
  if (which asdf | length) > 0 {
  
    section $"Syncing ASDF"
    cd $env.HOME

    let machine_name = (networksetup -getcomputername)
    $asdf_packages
    | where {|r| $r.machine_name == $machine_name}
    | par-each {|pkg|
    	asdf plugin add $pkg.plugin $pkg.version
    	asdf install $pkg.plugin $pkg.version
    	asdf set $pkg.plugin $pkg.version 
    }
    
  }
}


#== HOME BREW
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

# Homebrew: Returns machine required packages by type. see `brew_required_packages` variable
def brew-list-machine-required [] {
  let machine_name = (networksetup -getcomputername)
  $brew_required_packages
    | where {|r| $r.machine_name == $all or $r.machine_name == $machine_name}
    | select type package
    | flatten
}

# Homebrew: list installed packages
def brew-list-machine-installed [] {
  let formulaes = (run-external "brew" "leaves" | split row "\n")
            | wrap package
            | each {insert type {$f}}
  let casks = (run-external "brew" "list" "--casks" "--full-name" | split row "\n")
            | wrap package
            | each {insert type {$c}}
  $formulaes | append $casks | move type --before package | sort
}
alias bl = brew-list-machine-installed

# Homebrew: packages for sync action
def brew-list-machine-not-installed [] {
  let installed = brew-list-machine-installed 
  brew-list-machine-required | where {|p| $p not-in $installed }
}
# 
# Homebrew: packages for sync action
def brew-list-machine-not-required [] {
  let required = brew-list-machine-required 
  brew-list-machine-installed | where {|p| $p not-in $required }
}

# Homebrew: Upgrade, Sync Install and Clean
def brew-sync [] {
  brew-up

  brew-list-machine-not-installed
  | each {|row| run-external "brew" "install" $"--($row.type)" $row.package }
  
  brew-clean
}

# Pulls latest dotfiles and requests apps to reload configs where possible
def dot-sync [] {
  section "Pulling Dotfiles"
  git -C $env.DOTFILES pull

  # nushell reload
  source $nu.config-path
  source $nu.env-path
  
  # reload app configs
  run-external "aerospace" "reload-config"
}


# === DOTFILES
# refreshes machine dotfiles

# Sync dotfiles for package if application is installed, otherwise remove
# 
def stow-package [package: string, source: string, target: string] {
  if (which $package | length) > 0 {
    run-external "stow" "-S" "--dir" $source "--target" $target $package
    colorize $package green
  } else {
    run-external "stow" "-D" "--dir" $source "--target" $target $package
    colorize $package dark_gray
  }
}

# If the application exists on this machine
#   the dotfiles will be refreshed or added
# Else
#   the dotfiles is removed from the machine
def dot-stow [] {
  section "Syncing Dotfiles"
  dimmed $"from ($env.DOTFILES)"
  dimmed $"to   ($env.HOME)"
  
  ls --short-names $env.DOTFILES
  | where type == dir
  | par-each {|d| stow-package $d.name $env.DOTFILES $env.HOME }
}
