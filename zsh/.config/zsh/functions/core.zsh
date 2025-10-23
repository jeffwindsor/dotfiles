#!/usr/bin/env zsh
# core.zsh - Core utilities, print functions, and query commands

# ═══════════════════════════════════════════════════
# MISC
# ═══════════════════════════════════════════════════

# Syncs machine with latest config and installs
sync() {
  dots-pull
  brew-sync
  mise-sync
  dots-sync
}

# Change directory with clear and list
cdl() {
  cd "$1"
  clear
  [[ "${2:-true}" == "true" ]] && eza -la
  return 0
}

# Measure Zsh startup time
zsh-load-time() {
  time zsh -i -c exit
}

# ═══════════════════════════════════════════════════
# PRINT FUNCTIONS
# ═══════════════════════════════════════════════════

# Colorize text with ANSI codes
colorize() {
  local text="$1"
  local color="$2"
  case "$color" in
    red) echo -e "\033[31m${text}\033[0m" ;;
    green) echo -e "\033[32m${text}\033[0m" ;;
    yellow) echo -e "\033[33m${text}\033[0m" ;;
    blue) echo -e "\033[34m${text}\033[0m" ;;
    cyan) echo -e "\033[36m${text}\033[0m" ;;
    cyan_reverse) echo -e "\033[46;30m${text}\033[0m" ;;
    dark_gray) echo -e "\033[90m${text}\033[0m" ;;
    *) echo "$text" ;;
  esac
}

emphasize() {
  echo "== $1 =="
}

dimmed() {
  colorize "$1" "dark_gray"
}

fail() {
  colorize "$1" "red"
}

header() {
  colorize "$(emphasize "$1")" "cyan_reverse"
}

info() {
  colorize "$1" "blue"
}

normal() {
  echo "$1"
}

section() {
  colorize "$(emphasize "$1")" "cyan"
}

success() {
  colorize "$1" "green"
}

warning() {
  colorize "$1" "yellow"
}

# ═══════════════════════════════════════════════════
# QUERIES
# ═══════════════════════════════════════════════════

# Query aliases
query-aliases() {
  local query="$1"
  if [[ -z "$query" ]]; then
    alias
  else
    alias | grep -i "$query"
  fi
}

# Query functions
query-commands() {
  local query="$1"
  if [[ -z "$query" ]]; then
    typeset -f | grep -E '^\S+ \(\)' | sed 's/ ()//'
  else
    typeset -f | grep -E "^${query}" -A 1 | grep -v "^--$"
  fi
}

# Query everything
query-everything() {
  local query="$1"
  echo "=== Aliases ==="
  query-aliases "$query"
  echo -e "\n=== Functions ==="
  query-commands "$query"
}
