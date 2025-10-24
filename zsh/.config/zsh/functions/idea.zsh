#!/usr/bin/env zsh
# idea.zsh - IntelliJ IDEA Vim configuration management

# ═══════════════════════════════════════════════════
# IDEA VIM
# ═══════════════════════════════════════════════════

idea_key() {
  local file="$1"
  local target="${HOME}/.ideavimrc"
  local source="${DOTFILES}/idea-ce/.config/jetbrains/${file}"

  if [[ ! -f "$source" ]]; then
    print_error "Source file not found: $source"
    return 1
  fi

  ln -sF "$source" "$target"
  print_success "Linked ${file} to ${target}"
}
