$env.DOTFILES = ($env.SOURCE_JEFF | path join "dotfiles")

alias d = cdl $env.DOTFILES
alias de = edit $env.DOTFILES
alias dv = visual-edit $env.DOTFILES
alias ds = config nu
alias dg = lazygit --path $env.DOTFILES 

