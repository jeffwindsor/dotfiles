#!/usr/bin/env zsh

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

export EDITOR=nvim
export FZF_DEFAULT_COMMAND='fd --type f --hidden --ignore-file ~/.config/fdignore'
export FZF_DEFAULT_OPTS='--height 60% --layout=reverse --info=inline'
export GIT_LOG_PRETTY_FORMAT='%C(green)%h%C(auto)%d%C(reset) - %s | %C(cyan)%an %C(dim)%cr%C(reset)'
export HISTCONTROL=ignoreboth
export HISTFILE=${XDG_CACHE_HOME}/zsh/zsh_history   # put history to cache, seperating it from the other ZDOT files
export LESSHISTFILE="-"
export MANPAGER="sh -c 'col -bx | bat -l man -p'" # use bat as man pager
export NVIM_LOG_FILE=$HOME/.cache/nvim-log/
export NVM_DIR=$HOME/.config/nvim
export PATH=$PATH:$HOME/.local/bin
export SRC=$HOME/src
export TERM='xterm-256color'
export VSCODE_EXTENSIONS=$XDG_DATA_HOME/vscode-oss/extensions
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export ZSH_PLUGINS='/usr/local/share'

#######################################################################################
# NNN
#######################################################################################
# BLK="0B" CHR="0B" DIR="04" EXE="06" REG="00" HARDLINK="06" SYMLINK="06" MISSING="00" ORPHAN="09" FIFO="06" SOCK="0B" OTHER="06"  # NORD
BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"   # ONE DARK
export NNN_OPTS="H"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

#######################################################################################
# RUST / CARGO
#######################################################################################
source "$HOME/.cargo/env"

#######################################################################################
# MACOS-CJ
#######################################################################################
#export PATH="$PATH:$JAVA_HOME/bin"
#export PATH="$PATH:$SOFTWARE_HOME/bin"
#export PATH="$PATH:$SOFTWARE_HOME/resin"
export CLASSPATH="$SOFTWARE_HOME/bin:$CLASSPATH"
export DEVDB_HOST=devdb.db.cj.com
export DEVDB_PORT=1521
export DEVDB_SID=devdb
export DEVDB_USERNAME=spud
export DYLD_LIBRARY_PATH="$SOFTWARE_HOME/sqlplus/darwin"
export JAVA_HOME="/usr/libexec/java_home -v 11"
export MAVEN_OPTS="-Xmx8G -Xss3m -XX:ReservedCodeCacheSize=256m"
export PATH="/usr/local/opt/openjdk@11/bin:$PATH"
export PROJECTS_DIR="$HOME/.local/cjdev"
export SOFTWARE_HOME="$PROJECTS_DIR"
export TNS_ADMIN="$SOFTWARE_HOME/ci/tns-admin/"
