brew-syncbrew-cleanbrew-cleanbrew-upbrew-up
const brew_packages = [
  [machine_name,   package_type, package_name];
  
  [all_machines,   "formulae", "asdf"]
  [all_machines,   "formulae", "bash"]
  [all_machines,   "formulae", "carapace"]
  [all_machines,   "formulae", "fzf"]
  [all_machines,   "formulae", "git"]
  [all_machines,   "formulae", "helix"]
  [all_machines,   "formulae", "lazygit"]
  [all_machines,   "formulae", "nushell"]
  [all_machines,   "formulae", "ripgrep"]
  [all_machines,   "formulae", "starship"]
  [all_machines,   "formulae", "stow"]
  [all_machines,   "formulae", "television"]
  [all_machines,   "formulae", "yazi"]
  [all_machines,   "formulae", "zsh"]
  [all_machines,   "cask",     "claude"]
  [all_machines,   "cask",     "firefox"]
  [all_machines,   "cask",     "ghostty"]
  [all_machines,   "cask",     "google-chrome"]
  [all_machines,   "cask",     "jordanbaird-ice"]
  [all_machines,   "cask",     "keepingyouawake"]
  [all_machines,   "cask",     "nikitabobko/tap/aerospace"]
  [all_machines,   "cask",     "zed"]
  
  ["WKMZTAFD6544", "cask",     "intellij-idea"]
  ["WKMZTAFD6544", "cask",     "slack"]
  ["WKMZTAFD6544", "cask",     "tuple"]
  ["WKMZTAFD6544", "formulae", "aws-cdk"]
  ["WKMZTAFD6544", "formulae", "colima"]
  ["WKMZTAFD6544", "formulae", "docker-buildx"]
  ["WKMZTAFD6544", "formulae", "docker"]
  ["WKMZTAFD6544", "formulae", "lazydocker"]
  ["WKMZTAFD6544", "formulae", "lima"]
  ["WKMZTAFD6544", "formulae", "maven"]
  
  ["Midnight Air", "cask",     "balenaetcher"]
  ["Midnight Air", "cask",     "chatgpt"]
  ["Midnight Air", "cask",     "discord"]
  ["Midnight Air", "cask",     "iina"]
  ["Midnight Air", "cask",     "spotify"]
  ["Midnight Air", "cask",     "transmission"]
]

def to-result [action, type, name, result, f: closure] {
  {name: (do $f $name), type: (do $f $type), action:(do $f $action), result:(do $f $result)}
}

# sync and upgrade everything
def up [] {

  print (header "homebrew: sync")
  (brew-up)
  | append (brew-sync)
  | append (brew-clean)
  | print

  print (header "dotfiles: sync")
  (dot-up)
  | append (dot-sync)
  | print

}

#== DOTFILES / STOW
def dot-up [] {
  [(to-result "pull" "repo" "dotfiles" (git-pull $env.DOTFILES) {|t| show $t purple})]
}

def dot-sync [] {
  # sync dotfiles with user
  ls --short-names $env.DOTFILES
  | where type == dir
  | par-each {|d| stow-package $d.name $env.DOTFILES $env.HOME }
}

def stow-package [package: string, source: string, target: string] {
  # sync dotfile folder if application is installed, otherwise remove
  if (which $package | length) > 0 {
    run-external "stow" "-S" "--dir" $source "--target" $target $package
    to-result "update" "dots" $package "✓" {|t| success $t} 
  } else {
    run-external "stow" "-D" "--dir" $source "--target" $target $package
    to-result "purge" "dots" $package "≫" {|t| dimmed $t} 
  }
}


#== PACKAGES / HOMEBREW
def brew-up [] {
  [(to-result "upgrade" "brew" "packages" (run-external "brew" "upgrade" "--quiet") {|t| show $t purple} )]
}
def brew-clean [] {
  [(to-result "autoremove" "brew" "packages" (run-external "brew" "autoremove" ) {|t| show $t purple} )
   (to-result "clean" "brew" "cellar" (run-external "brew" "cleanup") {|t| show $t purple} )]
}
def brew-sync [packages = $brew_packages] {

  # filter packages for current machine
  let machine_name = (networksetup -getcomputername)
  let packages = $packages
    | where {|r| $r.machine_name == all_machines or $r.machine_name == $machine_name}
    | select package_type package_name
  
  # install any missing packages 
  (brew-sync-with $packages (brew list --cask --full-name | col) "cask")
  | append (brew-sync-with $packages (brew leaves) "formulae")
}

def brew-sync-with [required_packages, installed_packages, package_type] {
  # if required package is not installed then brew install else skip
  $required_packages
    | where package_type == $package_type
    | get package_name
    | par-each {|pkg|
      if ($pkg in $installed_packages) { 
        to-result "no-op" $package_type $pkg "≫" {|t| dimmed $t} 
      } else {
        to-result "install" $package_type $pkg (run-external "brew" "install" "--quiet" $"--($package_type)" $pkg) {|t| success $t} 
      }
    }
}

