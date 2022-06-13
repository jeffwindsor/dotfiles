#!/usr/bin/env zsh

# load all shel shared aliases
for rc in $XDG_CONFIG_HOME/aliases/*
do
    source $rc
done

# zsh config
export CLICOLOR=1
setopt LOCAL_OPTIONS EXTENDED_GLOB
setopt AUTO_MENU ALWAYS_TO_END AUTO_LIST NO_MENU_COMPLETE COMPLETE_IN_WORD NOMATCH
unsetopt FLOW_CONTROL
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
setopt share_history
setopt NOTIFY
setopt PROMPT_SUBST
setopt MULTIOS CDABLE_VARS
unsetopt correctall BEEP

HISTSIZE=50000
SAVEHIST=10000

compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

# auto/tab completion 
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)    #include hidden files

autoload -Uz compinit
compinit 
