
# Change IdeaVim config files 
def idea_key [file] {
  let target = $env.HOME | path join .ideavimrc
  let source = $env.DOTFILES | path join idea .config jetbrains $file
  ln -sF $source $target
}

alias idea_key_vim = idea_key ideavimrc
alias idea_key_helix = idea_key helix.vim
