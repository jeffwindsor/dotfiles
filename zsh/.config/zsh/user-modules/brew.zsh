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

  show_diff "Formulae" "${formulae_installed[@]}" "${formulae_bundled[@]}"
  show_diff "Casks" "${casks_installed[@]}" "${casks_bundled[@]}"
}

# Brew sync - update and install from Brewfile
brew-sync() {
  local machine=$(networksetup -getcomputername | tr -d '\n')
  local brewfile="${HOME}/Brewfile"

  print_section "Homebrew"
  print_info "   Updating Database (update)"
  brew update

  print_info "   Upgrading Packages (upgrade)"
  brew upgrade

  print_info "   Installing Bundle described in $brewfile"
  brew bundle install --file="$brewfile"

  print_info "   Removing Orphaned Packages (autoremove)"
  brew autoremove

  print_info "   Cleaning Up Package Cache (cleanup)"
  brew cleanup

  print_info "   List installed but not bundled packages"
  brew-diff "$brewfile"
}

# ═══════════════════════════════════════════════════
# ALIASES
# ═══════════════════════════════════════════════════
alias bn='brew install'
alias bi='brew info'
alias br='brew remove'
alias bs='brew search'
alias bsd='brew search --desc'
alias bd='brew-diff'
alias bl='brew-list'


