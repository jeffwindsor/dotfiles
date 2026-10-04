#!/usr/bin/env zsh
# brew.zsh - Homebrew package management functions

# ═══════════════════════════════════════════════════
# FUNCTIONS
# ═══════════════════════════════════════════════════

# List installed packages
brew-list() {
  print_section "Brew Formulae"
  brew leaves | sort
  echo ""
  print_section "Brew Casks"
  brew list --cask | sort
  echo ""
  print_section "Mise Installed"
  mise ls | tail -n +2 | awk 'NF'
}

# Brew diff - compare installed vs Brewfile
brew-diff() {
  local brewfile_path="${1:-$HOME/Brewfile}"

  if [[ ! -f "$brewfile_path" ]]; then
    print_error "Brewfile not found at: $brewfile_path, skipping auto install of packages"
    return 1
  fi

  # Extract package names from Brewfile (extract last component after / for tap paths)
  local formulae_bundled=($(grep '^brew "' "$brewfile_path" | sed 's/.*"\([^"]*\)".*/\1/' | sed 's|.*/||' | sort))
  local casks_bundled=($(grep '^cask "' "$brewfile_path" | sed 's/.*"\([^"]*\)".*/\1/' | sed 's|.*/||' | sort))

  # Get installed packages
  local formulae_installed=($(brew leaves | sort))
  local casks_installed=($(brew list --cask | sort))

  # Function to show differences
  show_diff() {
    local title="$1"
    local installed_count="$2"
    shift 2

    # First installed_count items are installed packages
    local -a inst=("${@:1:$installed_count}")
    # Remaining items are bundled packages
    local -a bund=("${@:$((installed_count + 1))}")

    # Find extras (installed but not in Brewfile)
    local -a extra=()
    for pkg in "${inst[@]}"; do
      local pkg_name="${pkg##*/}"
      if [[ ! " ${bund[@]} " =~ " ${pkg_name} " ]]; then
        extra+=("$pkg")
      fi
    done

    print_info "${title}:"
    if [[ ${#extra[@]} -eq 0 ]]; then
      print_muted "  (none)"
    else
      for pkg in "${extra[@]}"; do
        print_warning "  $(brew desc "$pkg" 2>/dev/null || echo "$pkg")"
      done
    fi

    echo "  Installed: ${#inst[@]}"
    echo "  Bundled:   ${#bund[@]}"
    echo "  Extra:     ${#extra[@]}"
    echo ""
  }

  show_diff "Formulae" "${#formulae_installed[@]}" "${formulae_installed[@]}" "${formulae_bundled[@]}"
  show_diff "Casks" "${#casks_installed[@]}" "${casks_installed[@]}" "${casks_bundled[@]}"
}

# Brew sync - update and install from Brewfile
sync-brew() {
  brew upgrade --yes 
  #brew bundle install --file="${HOME}/Brewfile"
  brew cleanup --prune=all
}

# ═══════════════════════════════════════════════════
# ALIASES
# ═══════════════════════════════════════════════════
alias bn='brew install'
alias bi='brew info'
alias br='brew remove'
alias bs='brew search'
alias bsd='brew search --desc'
alias bl='brew-list'


