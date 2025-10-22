#!/usr/bin/env zsh
# dotfiles.zsh - Dotfiles synchronization system

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
