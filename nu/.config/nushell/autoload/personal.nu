def l [] {
  clear
  ls -a
}
def --env cdl [path?:string] {
  cd $path
  l
}
def edit [path] { hx $path }
def visual-edit [path] { zed $path }

# navigation
alias "....." = cd ../../../../
alias "...." = cd ../../../
alias "..." = cd ../../
alias ".." = cd ..

# list
alias c = clear
alias cc = cdl $env.HOME
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
alias dg = lazygit --path $env.DOTFILES 

# applications
alias h = hx
alias "h." = hx .
alias bn = brew install
alias bi = brew info
alias bs = brew search
def bl [] {
  run-external "brew" "leaves" | print 
  run-external "brew" "list" "--casks" | print
}

# `sh` crutches
alias cat = open
alias fg = job unfreeze
alias jobs = job list
alias a = scope aliases

def ar [query] {
  scope aliases
  | where {|r| $r.expansion =~ $query or $r.name =~ $query}
}

def af [query] {
  scope commands
  | where command_type == "custom"
  | where name =~ $query
  | select name params 
}
