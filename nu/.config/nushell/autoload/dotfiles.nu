#!/usr/bin/env nu

$env.DOTFILES = ($env.SOURCE_JEFF | path join "dotfiles")

alias d = cdl $env.DOTFILES
alias de = edit $env.DOTFILES
alias dv = visual-edit $env.DOTFILES
alias ds = config nu
alias dg = lazygit --path $env.DOTFILES 

#== SYNC FUNCTIONS
def dot-pull [] {
  section "Pulling Dotfiles"
  dimmed $"to $($env.DOTFILES)"
  git-pull $env.DOTFILES

  source $nu.config-path
  source $nu.env-path
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
