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

autoload compinit
compinit

# FZF-TAB AFTER COMPINIT, BUT BEFORE WRAPPERS LIKE SYNTAX AND SUGGESTIONS
zinit light Aloxaf/fzf-tab
# zinit light zdharma-continuum/fast-syntax-highlighting
#zinit light zsh-users/zsh-autosuggestions

#==============================================================================
# Shell OPTIONS
setopt no_beep                  # no beep on error
setopt GLOB_DOTS                # allows fzf-tab to show hidden files by default
setopt completealiases          # Autocomplete command line switches for aliases
bindkey -e                      # emacs bindings

# History
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.




#==============================================================================
# shared
if test -f $HOME/.shellrc; then
  source "$HOME/.shellrc" zsh
fi 

