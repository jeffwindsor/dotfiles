#!/usr/bin/env zsh
# functions.zsh - All custom functions

# ═══════════════════════════════════════════════════
# PRINT UTILITIES
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
# CLAUDE / AI
# ═══════════════════════════════════════════════════

# Open Dev Mux in a repo
a() {
  local source=$(tv git-repos)
  cd "$source"
  zellij --layout claude
}

# Claude Bedrock configuration
claude_bedrock() {
  export CLAUDE_CODE_USE_BEDROCK="1"
  export AWS_REGION="us-west-2"
  export ANTHROPIC_MODEL="sonnet"
  export ANTHROPIC_SMALL_FAST_MODEL="haiku"
  ~/.config/claude/bedrock.sh
}

# ═══════════════════════════════════════════════════
# GIT FUNCTIONS
# ═══════════════════════════════════════════════════

# Git pull for specific repo
git-pull() {
  local path="$1"
  git -C "$path" pull
}

# List all git repos
git-repos() {
  local root_path="$1"
  find "$root_path" -type d -name ".git" -exec dirname {} \;
}

# Personal git clone wrapper
git-clone() {
  local repo_url="$1"

  # Parse git URL using regex
  if [[ "$repo_url" =~ git@([^:]+):(.+?)(\.git)?$ ]]; then
    local git_host="${match[1]}"
    local repo_path="${match[2]}"
  else
    echo "Invalid git URL format"
    return 1
  fi

  local target="${SOURCE}/${git_host}/${repo_path}"

  git clone "$repo_url" "$target"
  cd "$target" && ls -A
}

# Git diff with tv (terminal viewer)
gd() {
  tv git-diff
}

# Git log with tv
gl() {
  tv git-log
}

# Git reflog with tv
gr() {
  tv git-reflog
}

# Select git repo with tv
srcs() {
  local repo=$(tv git-repos)
  [[ -n "$repo" ]] && cdl "$repo"
}

# ═══════════════════════════════════════════════════
# YAZI
# ═══════════════════════════════════════════════════

# Yazi with directory change support
yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if local cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# ═══════════════════════════════════════════════════
# ZELLIJ
# ═══════════════════════════════════════════════════

# Kill all zellij sessions except current
zkill() {
  zellij list-sessions --no-formatting 2>/dev/null | \
    grep -v "current" | \
    awk '{print $1}' | \
    xargs -I {} zellij kill-session {}
}

# Delete all exited zellij sessions
zdelete() {
  zellij list-sessions --no-formatting 2>/dev/null | \
    grep "EXITED" | \
    awk '{print $1}' | \
    xargs -I {} zellij delete-session {}
}

# ═══════════════════════════════════════════════════
# HOMEBREW
# ═══════════════════════════════════════════════════

# List installed packages
bl() {
  section "Brew Formulae"
  brew leaves | sort
  echo ""
  section "Brew Casks"
  brew list --cask | sort
  echo ""
  section "Mise Installed"
  mise ls | tail -n +2 | awk 'NF'
}

# Brew diff - compare installed vs Brewfile
brew-diff() {
  local brewfile_path="${1:-$HOME/.config/homebrew/$(networksetup -getcomputername | tr -d '\n')/Brewfile}"

  if [[ ! -f "$brewfile_path" ]]; then
    fail "Brewfile not found at: $brewfile_path"
    return 1
  fi

  # Extract package names from Brewfile
  local formulae_bundled=($(grep '^brew "' "$brewfile_path" | sed 's/.*"\([^"]*\)".*/\1/' | sort))
  local casks_bundled=($(grep '^cask "' "$brewfile_path" | sed 's/.*"\([^"]*\)".*/\1/' | sort))

  # Get installed packages
  local formulae_installed=($(brew leaves | sort))
  local casks_installed=($(brew list --cask | sort))

  # Function to show differences
  show_diff() {
    local title="$1"
    shift
    local -a installed=("$@")

    # Split arrays - first half is installed, second half is bundled
    local split=$((($# + 1) / 2))
    local -a inst=("${@:1:$split}")
    local -a bund=("${@:$split+1}")

    # Find extras (installed but not in Brewfile)
    local -a extra=()
    for pkg in "${inst[@]}"; do
      if [[ ! " ${bund[@]} " =~ " ${pkg} " ]]; then
        extra+=("$pkg")
      fi
    done

    info "${title}:"
    if [[ ${#extra[@]} -eq 0 ]]; then
      dimmed "  (none)"
    else
      for pkg in "${extra[@]}"; do
        warning "  $(brew desc "$pkg" 2>/dev/null || echo "$pkg")"
      done
    fi

    normal "  Installed: ${#inst[@]}"
    normal "  Bundled:   ${#bund[@]}"
    normal "  Extra:     ${#extra[@]}"
    echo ""
  }

  show_diff "Formulae" "${formulae_installed[@]}" "${formulae_bundled[@]}"
  show_diff "Casks" "${casks_installed[@]}" "${casks_bundled[@]}"
}

# Brew sync - update and install from Brewfile
brew-sync() {
  section "Homebrews: Updating Database"
  brew update

  section "Homebrews: Upgrading All Packages"
  brew upgrade

  section "Homebrew: Installing Bundle"
  local machine=$(networksetup -getcomputername | tr -d '\n')
  local brewfile="${DOTFILES}/brew/.config/homebrew/${machine}/Brewfile"
  brew bundle install --file="$brewfile"

  section "Homebrews: Removing Orphaned Packages"
  brew autoremove

  section "Homebrews: Cleaning Up Package Cache"
  brew cleanup

  section "Homebrew: Extra Installed Packages"
  brew-diff "$brewfile"
}

# ═══════════════════════════════════════════════════
# MISE (runtime manager)
# ═══════════════════════════════════════════════════

mise-install-version() {
  local plugin="$1"

  if [[ -z "$plugin" ]]; then
    return
  fi

  local versions=$(mise ls-remote "$plugin")
  local version=$(echo -e "${versions}\nlatest" | sort -rV | tv --input-header "Select ${plugin} Version")

  if [[ -n "$version" ]]; then
    mise install "${plugin}@${version}"
  fi
}

mise-install() {
  local plugin="$1"

  if [[ -z "$plugin" ]]; then
    local asdfs=$(mise registry --backend asdf --hide-aliased)
    local cores=$(mise registry --backend core --hide-aliased)
    plugin=$(printf "%s\n%s" "$asdfs" "$cores" | tv --input-header "Select Plugin")
  fi

  mise-install-version "$plugin"
}

# Mise sync
mise-sync() {
  section "Mise: Syncing Global"
  local machine=$(networksetup -getcomputername | tr -d '\n')
  local source="${DOTFILES}/mise/.config/mise/${machine}/mise.local.toml"
  local target="${HOME}/mise.local.toml"
  ln -sf "$source" "$target"

  cd "$HOME"
  mise trust
  mise install
  cd - > /dev/null
}

# ═══════════════════════════════════════════════════
# SYNC SYSTEM
# ═══════════════════════════════════════════════════

# Main sync function
sync() {
  dot-pull
  brew-sync
  mise-sync
  ai-sync
  dot-sync
}

# Claude sync
ai-sync() {
  section "AI: Syncing Claude"
  local machine=$(networksetup -getcomputername | tr -d '\n')
  local source="${DOTFILES}/claude/.config/claude/${machine}/.claude_preferences.md"
  local target="${HOME}/.claude_preferences.md"
  ln -sf "$source" "$target"
}

# Dotfiles pull
dot-pull() {
  section "Pulling Dotfiles"
  git -C "$DOTFILES" pull

  # Reload zsh config
  source ~/.zshrc

  # Reload app configs
  command -v aerospace &> /dev/null && aerospace reload-config 2>/dev/null
}

# Stow individual package
stow-package() {
  local package="$1"
  local source="$2"
  local target="$3"

  if command -v "$package" &> /dev/null; then
    stow -S --dir "$source" --target "$target" "$package" 2>/dev/null
    colorize "$package" "green"
  else
    stow -D --dir "$source" --target "$target" "$package" 2>/dev/null
    colorize "$package" "dark_gray"
  fi
}

# Dotfiles sync
dot-sync() {
  section "Syncing Dotfiles"
  dimmed "from $DOTFILES"
  dimmed "to   $HOME"

  for dir in "$DOTFILES"/*/; do
    [[ -d "$dir" ]] || continue
    local package=$(basename "$dir")
    stow-package "$package" "$DOTFILES" "$HOME"
  done
}

# ═══════════════════════════════════════════════════
# SQLCL (Oracle SQL Command Line)
# ═══════════════════════════════════════════════════

sqlcl-connection() {
  local tns_name="$1"

  local user="${SQLCL_USERNAME}"
  if [[ -z "$user" ]]; then
    read -r "user?Enter username: "
  fi

  local password="${SQLCL_PASSWORD}"
  if [[ -z "$password" ]]; then
    read -rs "password?Enter database password: "
    echo ""  # New line after hidden input
  fi

  echo "${user}/\"${password}\"@${tns_name}"
}

sqlcl() {
  local tns_name="$1"

  if [[ -z "$tns_name" ]]; then
    local tnsnames=$(awk -F'=' '/^[A-Za-z0-9_]+[[:space:]]*=/ {gsub(/[[:space:]]/, "", $1); print $1}' ~/tnsnames.ora)
    tns_name=$(echo "$tnsnames" | tv)
  fi

  if [[ -z "$tns_name" ]]; then
    fail "No TNS name selected"
    return 1
  fi

  local connection_string=$(sqlcl-connection "$tns_name")
  "$HOME/bin/sqlcl/bin/sql" -S "$connection_string"
}

# ═══════════════════════════════════════════════════
# IDEA VIM
# ═══════════════════════════════════════════════════

idea_key() {
  local file="$1"
  local target="${HOME}/.ideavimrc"
  local source="${DOTFILES}/idea-ce/.config/jetbrains/${file}"

  if [[ ! -f "$source" ]]; then
    fail "Source file not found: $source"
    return 1
  fi

  ln -sF "$source" "$target"
  success "Linked ${file} to ${target}"
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
