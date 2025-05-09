# config.nu
# version = "0.101.0"

# editor for nushell configs
$env.config.buffer_editor = "hx"

# default welcome banner
$env.config.show_banner = false

# starship prompt
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

def header  [text] { show $" == ($text) == " blue true }
def section [text] { show $"== ($text) ==" blue }
def success [text] { show $text green }
def fail    [text] { show $text red }
def warning [text] { show $text yellow }
def dimmed  [text] { show $text dark_gray }
def normal  [text] { show $text reset }

def show [text, color, reverse=false] { $"(ansi (if $reverse {$"($color)_reverse"} else {$color}))($text)(ansi reset)" }

#== ENVIROMENT ==
$env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/bin')
load-env {
  
  "XDG_STATE_HOME": ($env.HOME | path join ".local/state")
  "XDG_DATA_HOME": ($env.HOME | path join ".local/share")
  "XDG_CACHE_HOME": ($env.HOME | path join ".cache")
  "XDG_CONFIG_HOME": ($env.HOME | path join ".config")
  "SOURCE": ($env.HOME | path join "Source")
  "SOURCE_GITHUB": ($env.SOURCE | path join "github.com")
  "SOURCE_GITCJ": ($env.SOURCE | path join "gitlab.cj.dev")
  "SOURCE_JEFF": ($env.SOURCE | path join "github.com/jeffwindsor")
  "DOTFILES": ($env.SOURCE_JEFF | path join "dotfiles")
  
  "HOMEBREW_PREFIX": "/opt/homebrew"
  "HOMEBREW_CELLAR": "/opt/homebrew/Cellar"
  "HOMEBREW_REPOSITORY": "/opt/homebrew"
  "HOMEBREW_NO_AUTO_UPDATE": "1"
  "HOMEBREW_NO_INSTALL_CLEANUP":"1"
}

#== ALIASES AND FUNCTIONS ==

def l [] { clear; ls -a }
def cdl [path?:string] { cd $path; l }
def edit [path] { hx $path }
def visual-edit [path] { zed $path }

# navigation
alias "....." = cd ../../../../
alias "...." = cd ../../../
alias "..." = cd ../../
alias ".." = cd ..

# list
alias c = clear
alias cc = cdl
alias la = ls -a
alias ll = ls -l
alias lla = ls -la

# repos / source files
alias src = cdl $env.SOURCE 
alias srcs = cdl (tv git-repos)
alias config = cdl $env.XDG_CONFIG_HOME 
alias hub = cdl $env.SOURCE_GITHUB 
alias lab = cdl $env.SOURCE_GITCJ 
alias empire = cdl ($env.SOURCE_GITCJ | path join "empire") 
alias jeff = cdl $env.SOURCE_JEFF 

# dotfiles
alias d = cdl $env.DOTFILES
alias de = edit $env.DOTFILES
alias dv = visual-edit $env.DOTFILES
alias ds = config nu

# muscle memory coverage, reduce over time
alias cat = open

alias gpl = git fetch
alias gph = git push
def git_pull [ path ] {
  run-external "git" "-C" $path "pull" "--quiet"
}

# os, package, dev env, and dotfile sync functions
source sync.nu

# AWESOME: https://github.com/nushell/awesome-nu?tab=readme-ov-file#plugins
# 
#   Investigate Plugins
#   https://github.com/cptpiepmatz/nu-plugin-highlight
#
#   Scripts
#   https://github.com/fj0r/ai.nu
#   https://github.com/KamilKleina/alias-finder.nu
#   https://github.com/fj0r/docker.nu
#
#   Completions
#   https://github.com/nushell/nu_scripts/tree/main/custom-completions
#
#   Integrations
#   https://github.com/selfagency/bru
#   https://github.com/carapace-sh/carapace-bin
#   https://github.com/direnv/direnv/blob/master/docs/hook.md#nushell
#   https://github.com/hustcer/deepseek-review
#   https://github.com/kellyjonbrazil/jc

