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
  ln -sf $source $target
}

# Mise: Sync Plugins and Versions
def mise-sync [] {
  section "Mise: Syncing Global"
  let	machine = (networksetup -getcomputername)
  let source = $env.DOTFILES | path join "mise" ".config" "mise" $machine "mise.local.toml"
  let target = $env.HOME | path join "mise.local.toml"
  ln -sf $source $target
  
  # operating on home directory to trust newly linked file and have install come from global file
  cd $env.HOME
  mise trust
  mise install
  cd -
}

def brew-diff [brewfile_path?: string] {
    # assume config brew file under machine name folder
    let brewfile_path = $brewfile_path | default (
        $env.HOME | path join ".config" "homebrew" (networksetup -getcomputername | str trim) "Brewfile"
    )
    
    def extract [type: string] { 
        open $brewfile_path 
        | lines 
        | where ($it | str starts-with $'($type) "') 
        | parse $'($type) "{name}"' 
        | get name 
        | sort 
    }
    
    def show [title: string, installed: list, bundled: list, width: int] {
        let extra = ($installed | where $it not-in $bundled)
        
        info $"($title):"
        if ($extra | is-empty) { 
            dimmed "  (none)" 
        } else { 
            $extra | each { |pkg| warning $"  ($pkg)" } 
        }
        
        let outputs = [ ["Installed" ($installed | length)]  ["Bundled  " ($bundled | length)]  ["Extra    " ($extra | length)] ]
        $outputs | each { |row|  normal $"  ($row.0): ($row.1 | into string | fill --alignment right --width $width)" }
        
        normal "\n"
    }

    let formulae = [(brew leaves | lines | sort) (extract "brew")]
    let casks = [(brew list --cask | lines | sort) (extract "cask")]
    let width = (
        [$formulae $casks] 
        | flatten 
        | each { length | into string | str length } 
        | math max
    )
    
    show "Formulae" $formulae.0 $formulae.1 $width
    show "Casks" $casks.0 $casks.1 $width
}
alias bd = brew-diff


def brew-sync [] {
  
  section "Homebrews: Updating Database"
  brew update
  
  section "Homebrews: Upgrading All Packages"
  brew upgrade

  section "Homebrew: Installing Bundle"
  let	machine = (networksetup -getcomputername)
  let brewfile = ($env.DOTFILES) | path join "brew" ".config" "homebrew" $machine "Brewfile"
  run-external "brew" "bundle" "install" $"--file=($brewfile)"

  section "Homebrew: Extra Installed Packages"
  brew-diff $brewfile

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
