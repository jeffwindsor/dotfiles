#!/usr/bin/env zsh
# .zshrc - Main Zsh Configuration
  # zmodload zsh/zprof

# ═══════════════════════════════════════════════════
# ZINIT PLUGIN MANAGER
# ═══════════════════════════════════════════════════
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# ═══════════════════════════════════════════════════
# ZSH OPTIONS
# ═══════════════════════════════════════════════════
# Keybindings
bindkey -e

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ═══════════════════════════════════════════════════
# ENVIRONMENT VARIABLES
# ═══════════════════════════════════════════════════
export EDITOR="nvim"
export VISUAL="zed"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# XDG Base Directory
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"

# Source Control
export SOURCE="${HOME}/Source"
export SOURCE_GITHUB="${SOURCE}/github.com"
export SOURCE_GITCJ="${SOURCE}/gitlab.cj.dev"
export SOURCE_JEFF="${SOURCE_GITHUB}/jeffwindsor"
export DOTFILES="${SOURCE_JEFF}/dotfiles"

# Homebrew
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export HOMEBREW_NO_AUTO_UPDATE="1"
export HOMEBREW_NO_INSTALL_CLEANUP="1"

# Autocompletion (ARGC)
ARGC_COMPLETIONS_ROOT="${SOURCE_GITHUB}/sigoden/argc-completions"
export ARGC_COMPLETIONS_ROOT
export ARGC_COMPLETIONS_PATH="${ARGC_COMPLETIONS_ROOT}/completions/macos:${ARGC_COMPLETIONS_ROOT}/completions"

# PATH Configuration
path=(
  "/opt/homebrew/bin"
  "${ARGC_COMPLETIONS_ROOT}"
  "${ARGC_COMPLETIONS_ROOT}/bin"
  "${HOME}/.local/bin"
  $path
)
export PATH

# ═══════════════════════════════════════════════════
# CORE FUNCTIONS (needed by aliases)
# ═══════════════════════════════════════════════════

# Change directory with clear and list
cdl() {
  cd "$1"
  clear
  [[ "${2:-true}" == "true" ]] && eza -la
  return 0
}

# ═══════════════════════════════════════════════════
# LOAD MODULES
# ═══════════════════════════════════════════════════

# Source all module files
ZSH_CONFIG_DIR="${DOTFILES}/zsh/.config/zsh"

[[ -f "${ZSH_CONFIG_DIR}/functions.zsh" ]] && source "${ZSH_CONFIG_DIR}/functions.zsh"
[[ -f "${ZSH_CONFIG_DIR}/aliases.zsh" ]] && source "${ZSH_CONFIG_DIR}/aliases.zsh"

# ═══════════════════════════════════════════════════
# EXTERNAL INTEGRATIONS
# ═══════════════════════════════════════════════════

# FZF
if command -v fzf &> /dev/null; then
  eval "$(fzf --zsh)"
fi

# Starship prompt
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# Mise (runtime manager)
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi

# Clean up zellij exited sessions on startup
if command -v zellij &> /dev/null; then
  zellij list-sessions --no-formatting 2>/dev/null | \
    grep "EXITED" | \
    awk '{print $1}' | \
    xargs -I {} zellij delete-session {} 2>/dev/null
fi

# zprof
