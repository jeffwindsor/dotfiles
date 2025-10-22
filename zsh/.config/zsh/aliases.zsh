#!/usr/bin/env zsh
# ═══════════════════════════════════════════════════
# BASIC UTILITIES
# ═══════════════════════════════════════════════════
alias p='pwd | pbcopy'
alias cat='bat --plain'
alias find='fd'
alias grep='rg'

# ═══════════════════════════════════════════════════
# DIRECTORY NAVIGATION
# ═══════════════════════════════════════════════════
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias c='clear'
alias cc='cdl $HOME false'
alias l='clear && eza -A'
alias la='eza -A'
alias ll='eza -l'
alias lla='eza -lA'
alias config='cdl $XDG_CONFIG_HOME'
alias tree='eza --tree'
alias treea='eza --tree --all'

# ═══════════════════════════════════════════════════
# EDITORS
# ═══════════════════════════════════════════════════
alias v='nvim'
alias v.='nvim .'
alias h='hx'
alias h.='hx .'

# ═══════════════════════════════════════════════════
# SOURCE CONTROL
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
alias gd='git-diff'
alias gl='git-log'
alias gr='git-reflog'

# ═══════════════════════════════════════════════════
# DOTFILES
# ═══════════════════════════════════════════════════
alias d='cdl $DOTFILES'
alias de='cd $DOTFILES && nvim'
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
alias bl='brew-list'

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
alias a='claude-dev'

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
