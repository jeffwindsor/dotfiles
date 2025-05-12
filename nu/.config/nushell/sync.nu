const asdf_packages = [
  [ machine_name,   plugin,   version];
	[ "WKMZTAFD6544", "java",   "corretto-21.0.7.6.1"]
	[ "WKMZTAFD6544", "maven",  "3.9.9"]
	[ "WKMZTAFD6544", "scala",  "2.12.18"]
	[ "WKMZTAFD6544", "nodejs", "20.19.1"]
	[ "WKMZTAFD6544", "awscli", "2.27.0"]
]
const brew_packages = [
  [machine_name,package_type, package_name];
  
  [all_machines,   formulae, "asdf"]
  [all_machines,   formulae, "bash"]
  [all_machines,   formulae, "carapace"]
  [all_machines,   formulae, "fzf"]
  [all_machines,   formulae, "git"]
  [all_machines,   formulae, "helix"]
  [all_machines,   formulae, "lazygit"]
  [all_machines,   formulae, "nushell"]
  [all_machines,   formulae, "ripgrep"]
  [all_machines,   formulae, "starship"]
  [all_machines,   formulae, "stow"]
  [all_machines,   formulae, "television"]
  [all_machines,   formulae, "yazi"]
  [all_machines,   formulae, "zsh"]
  [all_machines,   cask,     "claude"]
  [all_machines,   cask,     "firefox"]
  [all_machines,   cask,     "ghostty"]
  [all_machines,   cask,     "google-chrome"]
  [all_machines,   cask,     "jordanbaird-ice"]
  [all_machines,   cask,     "keepingyouawake"]
  [all_machines,   cask,     "nikitabobko/tap/aerospace"]
  [all_machines,   cask,     "zed"]
  
  ["WKMZTAFD6544", cask,     "intellij-idea"]
  ["WKMZTAFD6544", cask,     "slack"]
  ["WKMZTAFD6544", cask,     "tuple"]
  ["WKMZTAFD6544", formulae, "aws-cdk"]
  ["WKMZTAFD6544", formulae, "colima"]
  ["WKMZTAFD6544", formulae, "docker-buildx"]
  ["WKMZTAFD6544", formulae, "docker"]
  ["WKMZTAFD6544", formulae, "lazydocker"]
  ["WKMZTAFD6544", formulae, "lima"]
  ["WKMZTAFD6544", formulae, "maven"]
  
  ["Midnight Air", cask,     "balenaetcher"]
  ["Midnight Air", cask,     "chatgpt"]
  ["Midnight Air", cask,     "discord"]
  ["Midnight Air", cask,     "iina"]
  ["Midnight Air", cask,     "spotify"]
  ["Midnight Air", cask,     "transmission"]
]

# sync and upgrade everything
def up [] {
  dot-up
  brew-up
  
  brew-sync $brew_packages 
  brew-clean
  dot-sync
  asdf-sync $asdf_packages
}

#== DOTFILES / STOW
def dot-up [] {
  section "Pulling Dotfiles"
  dimmed $"to $($env.DOTFILES)"
  git-pull $env.DOTFILES
}

def dot-sync [] {
  section "Syncing Dotfiles"
  dimmed $"from $($env.DOTFILES)"
  dimmed $"to   $($env.HOME)"
  ls --short-names $env.DOTFILES
  | where type == dir
  | par-each {|d| stow-package $d.name $env.DOTFILES $env.HOME }
}

def stow-package [package: string, source: string, target: string] {
  # sync dotfile folder if application is installed, otherwise remove
  if (which $package | length) > 0 {
    success $"  ($package): synced"
    run-external "stow" "-S" "--dir" $source "--target" $target $package
  } else {
    dimmed $"  ($package): cleaned"
    run-external "stow" "-D" "--dir" $source "--target" $target $package
  }
}


#== PACKAGES / HOMEBREW
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
def brew-sync [packages = $brew_packages] {

  # filter packages for current machine
  let machine_name = (networksetup -getcomputername)
  section $"Syncing Brews on ($machine_name)"
  let packages = $packages
    | where {|r| $r.machine_name == all_machines or $r.machine_name == $machine_name}
    | select package_type package_name
  
  # install any missing packages 
  brew-sync-with $packages (brew list --cask --full-name | col) cask
  brew-sync-with $packages (brew leaves) formulae
}

def brew-sync-with [required_packages, installed_packages, package_type] {
  # if required package is not installed then brew install else skip
  $required_packages
    | where package_type == $package_type
    | get package_name
    | par-each --keep-order {|pkg|
      if ($pkg in $installed_packages) { 
        dimmed $"  ($pkg) no-op"
      } else {
        info $"  ($pkg) ($package_type) installing" 
        run-external "brew" "install" "--quiet" $"--($package_type)" $pkg
      }
    }
}


# ASDF
def asdf-sync [packages = $asdf_packages] {
  section $"Syncing ASDF"
  $asdf_packages
  | par-each --keep-order {|pkg|
    info $"  ($pkg.plugin) ($pkg.version)"
  	asdf plugin add $pkg.plugin $pkg.version
  	asdf install $pkg.plugin $pkg.version
  	asdf set $pkg.plugin $pkg.version
  }
}
