#!/usr/bin/env nu

const asdf_packages = [
  [ machine_name,   plugin,   version];
  
	[ "WKMZTAFD6544", "java",   "corretto-21.0.7.6.1"]
	[ "WKMZTAFD6544", "maven",  "3.9.9"]
	[ "WKMZTAFD6544", "scala",  "2.12.18"]
	[ "WKMZTAFD6544", "nodejs", "20.19.1"]
	[ "WKMZTAFD6544", "awscli", "2.27.0"]
]
const brew_packages = [
  [machine_name,   type,     packages];
  
  [all_machines,   formulae, ["asdf" "bash" "carapace" "fzf" "git" "helix" "lazygit" "nushell" "ripgrep" "starship" "stow" "television" "yazi" "zsh"]]
  ["Midnight Air", formulae, []]
  ["WKMZTAFD6544", formulae, ["aws-cdk" "colima" "docker-buildx" "docker" "lazydocker" "lima" "maven"]]
  
  [all_machines,   cask,     ["claude" "firefox" "ghostty" "google-chrome" "jordanbaird-ice" "keepingyouawake" "nikitabobko/tap/aerospace" "zed"]]
  ["WKMZTAFD6544", cask,     ["intellij-idea" "slack" "tuple", "visual-studio-code"]]
  ["Midnight Air", cask,     ["balenaetcher" "chatgpt" "discord" "iina" "spotify" "transmission"]]
]

# sync and upgrade everything
def up [] {
  dot-pull
  brew-up
  brew-sync 
  brew-clean
  dot-sync
  asdf-sync

  # reload application configs
  # run-external "ghostty" "+reload-config"  # not implemented yet
  run-external "aerospace" "reload-config"
}

#== DOTFILES / STOW
def dot-pull [] {
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
    run-external "stow" "-S" "--dir" $source "--target" $target $package
    success $"  ($package)"
  } else {
    run-external "stow" "-D" "--dir" $source "--target" $target $package
    fail $"  ($package)"
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
    | select type packages
  
  # install any missing packages 
  brew-sync-with cask $packages (brew list --cask --full-name | col)
  brew-sync-with formulae $packages (brew leaves)
}

def brew-sync-with [type, required_packages, installed_packages] {
  # if required package is not installed then brew install else skip
  $required_packages
    | where type == $type
    | get packages | flatten
    | par-each --keep-order {|pkg|
      if ($pkg in $installed_packages) { 
        dimmed $" ($pkg)"
      } else {
        info $" ($pkg)" 
        run-external "brew" "install" "--quiet" $"--($type)" $pkg
      }
    }
}


# ASDF
def asdf-sync [packages = $asdf_packages] {
  if (which asf | length) > 0 {
    section $"Syncing ASDF"
    cd $env.HOME
    $asdf_packages
    | par-each --keep-order {|pkg|
    	asdf plugin add $pkg.plugin $pkg.version
    	asdf install $pkg.plugin $pkg.version
    	asdf set $pkg.plugin $pkg.version 
    }
  }
}
