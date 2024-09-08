#!/usr/bin/env zsh

#==============================================================================
# Environment (setting here instead of .zshenv for ability to re-source)
#==============================================================================

# avoids insecure directories warning
export ZSH_DISABLE_COMPFIX="true"

# xdg-ify
export XDG_STATE_HOME=$HOME/.local/state
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config

# personal
export SRC=$HOME/Source

#==============================================================================
# ZSH plugin manager: https://github.com/zdharma-continuum/zinit
#==============================================================================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"
#zinit self-update

# plugin - Fish shell-like syntax highlighting for Zsh
zinit light zsh-users/zsh-syntax-highlighting
# plugin - Homebrew commands enhanced with fzf 
zinit light thirteen37/fzf-brew
# plugin - Lightweight git via fzf
zinit load wfxr/forgit
# plugin - replace zsh's default completion selection menu with fzf!
# Add this as the last plugin just in case of conflicts
zinit light Aloxaf/fzf-tab
zinit snippet OMZP::asdf

# initialize ZSH
autoload -Uz compinit && compinit
zinit cdreplay -q

#==============================================================================
# Shell OPTIONS
#==============================================================================

# remove the beep
unsetopt BEEP
# VIM FTW, change to -e if you are more an emacs person
bindkey -v
# History config: reasonable history size, lowering of duplicate entries by various means
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory 
setopt hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

# ZSH Completion Styling
# match on case independent values
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# ZOXIDE: add previews to tab completes
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
# FZF TAB : Suggested
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
# initialize programs
#==============================================================================

# package manager: https://github.com/Homebrew
if [[ -f "/opt/homebrew/bin/brew" ]] then
  # only auto-updates db every 12+ hours
  export HOMEBREW_AUTO_UPDATE_SECS=43200

  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# personal aliases (shell independent)
if test -f $HOME/.aliasrc; then
  source $HOME/.aliasrc
fi 

# Source Control: https://github.com/git/git
if command -v git &>/dev/null; then
  export GIT_LOG_PRETTY_FORMAT='%C(green)%h%C(reset) - %s%C(cyan) | %an%C(dim) | %ch%C(auto)%d%C(reset)'
fi 

# GREP replacement: https://github.com/BurntSushi/ripgrep
if command -v rg &>/dev/null; then
  export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"
fi 

# fuzzy finder: https://github.com/junegunn/fzf
if command -v fzf &>/dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --ignore-file ~/.config/fdignore'
  export FZF_DEFAULT_OPTS='--info=inline --reverse --border none --preview "bat {}" --preview-window down'

  eval "$(fzf --zsh)"
fi

# change directory replacement: https://github.com/ajeetdsouza/zoxide
if command -v zoxide &>/dev/null; then
  # init replaces cd with z, and cdi with zi 
  eval "$(zoxide init --cmd cd zsh)"
fi

# Prompt : https://github.com/starship/starship
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# Extendable version manager : https://github.com/asdf-vm/asdf
if command -v $(brew --prefix asdf)/libexec/asdf.sh &>/dev/null; then
  # node
  export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmconfig
  export NPM_PACKAGES=$HOME/.npm-packages
  export NVM_DIR="$XDG_DATA_HOME"/nvm

  source $(brew --prefix asdf)/libexec/asdf.sh
fi
