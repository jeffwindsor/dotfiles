#!/usr/bin/env zsh
# zmodload zsh/zprof		# turn this on the profile load times. use `zprof` to get results

#compaudit | xargs chmod g-w		# resolves unsecure directories warnings
autoload -Uz compinit -u
compinit


#== Shell OPTIONS
setopt no_beep         # no beep on error
setopt GLOB_DOTS       # allows fzf-tab to show hidden files by default
# setopt completealiases # Autocomplete command line switches for aliases
bindkey -e             # emacs bindings

#== Zsh History
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=1000
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY       # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY          # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS       # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a previously found event.
setopt HIST_IGNORE_SPACE      # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS      # Do not write a duplicate event to the history file.


#== Plugins
export ZSH_PLUGIN_DIR="$HOME/.local/share/zsh/plugins"

function load_plugin(){
	local plugin_repo=$1
	local plugin_init_file=$2
	
	# if the plugin is not found clone it first	
	if [[ ! -e "$ZSH_PLUGIN_DIR/$plugin_repo" ]]; then
  		git clone --depth=1 "https://github.com/$plugin_repo.git" "$ZSH_PLUGIN_DIR/$plugin_repo"
	fi
	if [[ -v plugin_init_file ]]; then
		source "$ZSH_PLUGIN_DIR/$plugin_repo/$plugin_init_file"
	fi
}

load_plugin "Aloxaf/fzf-tab" "fzf-tab.plugin.zsh"
load_plugin "zsh-users/zsh-syntax-highlighting" "zsh-syntax-highlighting.zsh"
load_plugin "zsh-users/zsh-completions"

# keep load_plugin function local to zshrc
unfunction load_plugin

#== Personal multi-shell rc file
[ -f $HOME/.shellrc ] &&  source "$HOME/.shellrc" zsh
