# config.nu
# version = "0.101.0"

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

# editor for nushell configs
$env.config.buffer_editor = "hx"

# default welcome banner
$env.config.show_banner = false

# starship prompt
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")



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

def up [] {

  # homebrew sync and upgrade
  brew_sync [ claude firefox ghostty google-chrome jordanbaird-ice keepingyouawake nikitabobko/tap/aerospace zed ] [ asdf bash carapace git helix lazygit nushell ripgrep starship stow television yazi zsh ]
  run-external "brew" "upgrade"

  # pull dot files and sync dotfiles with stow
  run-external "git" "-C" $env.DOTFILES "pull"
  ls $env.DOTFILES
  | where type == dir
  | each {|d| stow-package $d.name $env.DOTFILES $env.HOME }
  
}

#== STOW
def stow-package [package: string, source: string, target: string] {
  if (which $package | length) > 0 {
    print $"(ansi light_green) ($package): synced (ansi reset)"
    run-external "stow" "-S" "--dir" $source "--target" $target $package
  } else {
    print $"(ansi default_dimmed) ($package): not installed (ansi reset)"
    run-external "stow" "-D" "--dir" $source "--target" $target $package
  }
}


#== HOMEBREW
def brew_sync [brew_casks: list<string>, brew_formulaes: list<string>] {
  let machine_name = (networksetup -getcomputername)
  
  let c_add = match $machine_name {
   "Midnight Air" => ($brew_casks | append [ balenaetcher chatgpt discord iina spotify transmission ])
   "WKMZTAFD6544" => ($brew_casks | append [ intellij-idea slack tuple ])
  }
	let c_current = (brew list --cask --full-name | col)
  # install any missing casks 
  print " BREW CASKS "
  $c_add | filter {|c| not ($c in $c_current)} | each {|c| brew install --cask $c }

  
  let f_add = match $machine_name {
   "Midnight Air" => $brew_formulaes
   "WKMZTAFD6544" => ($brew_formulaes | append [ aws-cdk colima docker docker-buildx lazydocker lima maven ])
  }
	let f_current = (brew leaves)
  # install any missing formulae
  print " BREW FORMULAES "
  $f_add | filter {|f| not ($f in $f_current)} | each {|f| brew install --formulae $f }
  
}

#== LAZYGIT
alias gg = lazygit

#== GIT
alias gd = git diff --word-diff --unified=0
alias gb = git blame -w -C -C -C
alias gs = git status
alias gph = git push
alias gpl = git pull

def git_clone [repo_url:string] {
  # extract the host and repo path 
	let parsed = ($repo_url | parse --regex '(?:git@(?P<git_host>[^:]+)):?(?P<repo_path>.+?)(?:\.git)?$')
  let target = $'($env.SOURCE)/($parsed.git_host)/($parsed.repo_path)'
  
	# clone repo to my source directory with full folder tree
	clear
	print $'(ansi lu) ==> cloning ($repo_url) into ($target) (ansi reset)'
	git clone $repo_url $target

	# change to the repo local directory, clear and ls -la
	cd $target
	ls -a
}

# muscle memory coverage, reduce over time
alias cat = open

