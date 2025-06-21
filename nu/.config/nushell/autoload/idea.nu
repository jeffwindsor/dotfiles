
# Change IdeaVim Keymaps to vim
def idea_key [file] {
  let target = $env.HOME | path join .vimrc
  let source = $env.DOTFILES | path join idea .config jetbrains $file
  ln -s $source $target
}

alias idea_key_vim = idea_key idea.vimrc
alias idea_key_helix = idea_key idea.helixrc
