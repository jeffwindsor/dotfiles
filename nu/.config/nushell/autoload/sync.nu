
const brew_required_packages = [
  [machine_name,   type,     packages];
  
  [all_machines,   formulae, ["asdf" "bash" "carapace" "fzf" "git" "helix" "lazygit" "nushell" "ripgrep" "starship" "stow" "television" "yazi" "zsh"]]
  ["Midnight Air", formulae, []]
  ["WKMZTAFD6544", formulae, ["aws-cdk" "colima" "docker-buildx" "docker" "lazydocker" "lima" "maven"]]
  
  [all_machines,   cask,     ["claude" "firefox" "ghostty" "google-chrome" "jordanbaird-ice" "keepingyouawake" "nikitabobko/tap/aerospace" "zed"]]
  ["WKMZTAFD6544", cask,     ["intellij-idea" "slack" "tuple", "visual-studio-code"]]
  ["Midnight Air", cask,     ["balenaetcher" "chatgpt" "discord" "iina" "spotify" "transmission"]]
]

const asdf_packages = [
  [ machine_name,   plugin,   version];
  
	[ "WKMZTAFD6544", "java",   "corretto-21.0.7.6.1"]
	[ "WKMZTAFD6544", "maven",  "3.9.9"]
	[ "WKMZTAFD6544", "scala",  "2.12.18"]
	[ "WKMZTAFD6544", "nodejs", "20.19.1"]
	[ "WKMZTAFD6544", "awscli", "2.27.0"]
]

def sync [] {
  dot-sync

  brew-up
  brew-sync-install cask
  brew-sync-install formulae
  brew-clean

  asdf-sync

  dot-stow
}

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


#== SYNC FUNCTIONS
export def brew-up [] {
  section "Upgrading Brews"
  run-external "brew" "upgrade" | print
}

def brew-clean [] {
  section "Remove Orphaned Brews"
  run-external "brew" "autoremove" | print
  section "Clean up Cellar"
  run-external "brew" "cleanup" | print
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

#== SYNC FUNCTIONS
def dot-sync [] {
  section "Pulling Dotfiles"
  git -C $env.DOTFILES pull

  source $nu.config-path
  source $nu.env-path

  run-external "aerospace" "reload-config"
}

def dot-stow [] {
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
