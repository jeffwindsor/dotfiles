#!/usr/bin/env zsh

# avoids insecure directories warning
export ZSH_DISABLE_COMPFIX="true"

#==============================================================================
# ZSH plugin manager: https://github.com/zdharma-continuum/zinit
#==============================================================================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
# Initialize zinit
source "${ZINIT_HOME}/zinit.zsh"
#==============================================================================
# Plugins
zinit snippet OMZP::asdf
[ -x "$(command -v foo)" ] && zinit light thirteen37/fzf-brew
zinit light zsh-users/zsh-syntax-highlighting
zinit light z-shell/zsh-zoxide
zinit light Aloxaf/fzf-tab    # ******  Add this as the last plugin just in case of conflicts
#==============================================================================


# initialize ZSH
autoload -Uz compinit && compinit
zinit cdreplay -q

#==============================================================================
# Shell OPTIONS
unsetopt BEEP # remove the beep
bindkey -e # emacs bindings
# History config: reasonable history size, lowering of duplicate entries by various means
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory 
setopt hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

# ZSH Completion Styling - FZF-TAB Suggested
#   disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
#   set descriptions format to enable group support
#   NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
#   set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#   force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
#   preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
#   switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'


#==============================================================================
# shared
if test -f $HOME/.shellrc; then
  source "$HOME/.shellrc" zsh
fi 

