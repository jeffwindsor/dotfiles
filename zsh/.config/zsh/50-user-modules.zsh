#!/usr/bin/env zsh

# sync everything
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
  lsd -A
}

# Measure Zsh startup time
zsh-load-time() {
  # zmodload zsh/zprof
  # zprof
  time zsh -i -c exit
}

# ═══════════════════════════════════════════════════
# PRINT FUNCTIONS
# ═══════════════════════════════════════════════════

# Internal colorize helper (private)
_colorize() {
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

# Public namespaced print functions
print_error()   { _colorize "$1" "red" }
print_success() { _colorize "$1" "green" }
print_warning() { _colorize "$1" "yellow" }
print_info()    { _colorize "$1" "blue" }
print_muted()   { _colorize "$1" "dark_gray" }
print_header()  { _colorize "== $1 ==" "cyan_reverse" }
print_section() { _colorize "== $1 ==" "cyan" }

# ═══════════════════════════════════════════════════
# QUERY user functions and alaises 
# ═══════════════════════════════════════════════════

# Interactive picker for aliases and functions
pick() {
  local tmpdir selected
  tmpdir=$(mktemp -d)

  # Write each function definition to its own file
  typeset -f | awk -v dir="$tmpdir" '
    /^[a-zA-Z_][a-zA-Z0-9_.-]* \(\)/ { name=$1; file=dir "/" name }
    name { print > file }
    /^\}$/ { name=""  }
  '

  selected=$(
    {
      alias | sed 's/=/\t/'
      ls "$tmpdir" | grep -v '^_' | sed 's/.*/&\t/'
    } | fzf \
      --prompt="Pick: " \
      --height=100% \
      --border \
      --delimiter='\t' \
      --with-nth=1 \
      --preview="if [[ -f $tmpdir/{1} ]]; then cat $tmpdir/{1}; else echo {2}; fi" \
      --preview-window=right:60%:wrap
  )
  rm -rf "$tmpdir"
  [[ -z "$selected" ]] && return 0
  print -z "${selected%%	*}"
}

# ═══════════════════════════════════════════════════
# DOTFILES
# ═══════════════════════════════════════════════════
dots-pull() {
  print_section "Pulling Dotfiles"
  git -C "$DOTFILES" pull

  # Reload zsh config
  source ~/.zshrc

  # Reload app configs
  command -v aerospace &> /dev/null && aerospace reload-config 2>/dev/null
}

# ═══════════════════════════════════════════════════
# ALIASES
# ═══════════════════════════════════════════════════
alias pp='pwd | pbcopy'
alias p='pick'
alias cat='bat --plain'
alias find='fd'
alias grep='rg'

# DIRECTORY NAVIGATION
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias c='clear'
alias cc='cdl $HOME false'
alias l='clear && lsd --git'
alias la='clear && lsd -A --git'
alias ll='lsd -l --git'
alias lla='lsd -lA --git'
alias config='cdl $XDG_CONFIG_HOME'
alias tree='lsd --tree --git'
alias treea='lsd --tree --all --git'

# DIRECTORY ALIASES
alias src='cdl $SOURCE'
alias hub='cdl $SOURCE_GITHUB'
alias lab='cdl $SOURCE_GITCJ'
alias empire='cdl $SOURCE_GITCJ/empire'
alias jeff='cdl $SOURCE_JEFF'



# ═══════════════════════════════════════════════════
# Load user modules only if command is reachable.  user-modules expected to be named by the cammand 
# not the package name, for example `nvim.zsh` not `neovim.zsh`
# ═══════════════════════════════════════════════════
for func in "${ZSH_CONFIG_DIR}"user-modules/*.zsh; do
  local func_name=$(basename "$func" .zsh)
  source "$func"
done

# TODO: hack for sqlcl special case, shich has a non standard install of sqlcl in the ~/bin directory
source $XDG_CONFIG_HOME/zsh/user-modules/sqlcl.zsh
