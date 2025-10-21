#!/usr/bin/env zsh
# aliases.zsh - All shell aliases

# ═══════════════════════════════════════════════════
# BASIC UTILITIES
# ═══════════════════════════════════════════════════
alias p='pwd | pbcopy'

# Muscle memory helpers
alias cat='bat --plain'
alias find='fd'
alias grep='rg'

# ═══════════════════════════════════════════════════
# DIRECTORY NAVIGATION
# ═══════════════════════════════════════════════════
alias c='clear'
alias l='clear && ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cc='cdl $HOME false'
alias la='ls -A'
alias ll='ls -l'
alias lla='ls -lA'
alias config='cdl $XDG_CONFIG_HOME'

# ═══════════════════════════════════════════════════
# EZA (modern ls replacement)
# ═══════════════════════════════════════════════════
alias x='eza'
alias xa='eza --all'
alias xl='eza --long'
alias xla='eza --long --all'
alias xt='eza --tree'
alias tree='eza --tree'
alias xta='eza --tree --all'
alias treea='eza --tree --all'

# ═══════════════════════════════════════════════════
# EDITORS
# ═══════════════════════════════════════════════════
alias v='nvim'
alias v.='nvim .'
alias h='hx'
alias h.='hx .'

# ═══════════════════════════════════════════════════
# GIT & SOURCE CONTROL
# ═══════════════════════════════════════════════════
alias src='cdl $SOURCE'
alias hub='cdl $SOURCE_GITHUB'
alias lab='cdl $SOURCE_GITCJ'
alias empire='cdl $SOURCE_GITCJ/empire'
alias jeff='cdl $SOURCE_JEFF'

# Git commands
alias gb='git blame -w -C -C -C'
alias gg='lazygit'
alias gs='git status'
alias gph='git push'
alias gpl='git pull'

# ═══════════════════════════════════════════════════
# DOTFILES
# ═══════════════════════════════════════════════════
alias d='cdl $DOTFILES'
alias de='nvim $DOTFILES'
alias dv='zed $DOTFILES'
alias ds='cdl $XDG_CONFIG_HOME/nushell'
alias dg='lazygit --path $DOTFILES'

# ═══════════════════════════════════════════════════
# HOMEBREW
# ═══════════════════════════════════════════════════
alias bn='brew install'
alias bi='brew info'
alias bs='brew search'
alias bsd='brew search --desc'
alias bd='brew-diff'

# ═══════════════════════════════════════════════════
# ZELLIJ (terminal multiplexer)
# ═══════════════════════════════════════════════════
alias z='zellij'
alias zc='zellij --layout claude'
alias zd='zellij --layout dev'
alias zl='zellij ls'

# ═══════════════════════════════════════════════════
# YAZI (file manager)
# ═══════════════════════════════════════════════════
alias y='yazi'

# ═══════════════════════════════════════════════════
# OTHER TOOLS
# ═══════════════════════════════════════════════════
alias ff='fastfetch'
alias aa='claude'

# SQLCL database shortcuts
alias shopcart='sqlcl "SHOPCART"'
alias t5='sqlcl "TCJOWEB5"'
alias t1='sqlcl "TCJOWEB1"'

# Query shortcuts
alias qa='query-aliases'
alias qc='query-commands'
alias qq='query-everything'

# IdeaVim shortcuts
alias idea_key_vim='idea_key ideavimrc'
alias idea_key_helix='idea_key helix.vim'
