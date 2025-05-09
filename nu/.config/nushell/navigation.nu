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



