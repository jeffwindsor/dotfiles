#!/usr/bin/env zsh
# .zshenv - Environment configuration for ALL shells
# Read by: interactive, non-interactive, login, and script shells

# ═══════════════════════════════════════════════════
# SYSTEM OPTIONS
# ═══════════════════════════════════════════════════
# Prevent reading system-wide /etc/zsh* files
setopt no_global_rcs

# ═══════════════════════════════════════════════════
# HOMEBREW INITIALIZATION
# ═══════════════════════════════════════════════════
# Must be early for PATH setup
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ═══════════════════════════════════════════════════
# XDG BASE DIRECTORY SPECIFICATION
# ═══════════════════════════════════════════════════
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"

# ═══════════════════════════════════════════════════
# CORE ENVIRONMENT VARIABLES
# ═══════════════════════════════════════════════════
export EDITOR="nvim"
export VISUAL="zed"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# ═══════════════════════════════════════════════════
# SOURCE CONTROL DIRECTORIES
# ═══════════════════════════════════════════════════
export SOURCE="${HOME}/Source"
export SOURCE_GITHUB="${SOURCE}/github.com"
export SOURCE_GITCJ="${SOURCE}/gitlab.cj.dev"
export SOURCE_JEFF="${SOURCE_GITHUB}/jeffwindsor"
export DOTFILES="${SOURCE_JEFF}/dotfiles"

# ═══════════════════════════════════════════════════
# HOMEBREW CONFIGURATION
# ═══════════════════════════════════════════════════
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export HOMEBREW_NO_AUTO_UPDATE="1"
export HOMEBREW_NO_INSTALL_CLEANUP="1"

# ═══════════════════════════════════════════════════
# ZSH CONFIGURATION
# ═══════════════════════════════════════════════════
export ZSH_COMPDUMP="${XDG_CACHE_HOME}/zsh/.zcompdump"

# ═══════════════════════════════════════════════════
# AUTOCOMPLETION (ARGC)
# ═══════════════════════════════════════════════════
export ARGC_COMPLETIONS_ROOT="${SOURCE_GITHUB}/sigoden/argc-completions"
export ARGC_COMPLETIONS_PATH="${ARGC_COMPLETIONS_ROOT}/completions/macos:${ARGC_COMPLETIONS_ROOT}/completions"

# ═══════════════════════════════════════════════════
# PATH CONFIGURATION
# ═══════════════════════════════════════════════════
path=(
  "/opt/homebrew/bin"
  "${ARGC_COMPLETIONS_ROOT}"
  "${ARGC_COMPLETIONS_ROOT}/bin"
  "${HOME}/.local/bin"
  $path
)
export PATH
