$env.DOTFILES = ($env.SOURCE_JEFF | path join "dotfiles")

alias d = cdl $env.DOTFILES
alias de = hx $env.DOTFILES
alias dv = zed $env.DOTFILES
alias ds = config nu
alias dg = lazygit --path $env.DOTFILES 

