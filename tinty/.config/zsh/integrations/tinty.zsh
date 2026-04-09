#!/usr/bin/env zsh
if command -v tinty &>/dev/null; then
  tinty-setup()  { tinty sync && theme }
  tinty-update() { tinty sync && tinty init }

  theme() {
    local state_dir="${XDG_DATA_HOME:-$HOME/.local/share}/tinted-theming/tinty"
    local favorites_file="${XDG_CONFIG_HOME:-$HOME/.config}/tinted-theming/tinty/favorites"
    if [[ ! -f "$state_dir/current_scheme" ]]; then
      echo "tinty is not initialized."
      read "reply?Run tinty-setup now? [y/N] "
      [[ "$reply" =~ ^[Yy]$ ]] && tinty-setup || return 0
    fi

    local mode
    mode=$(printf 'Favorites\nAll Themes\n' | fzf --prompt="Theme source: " --height=15% --border)
    [[ -z "$mode" ]] && return 0

    local selected
    if [[ "$mode" == "Favorites" ]]; then
      selected=$(cat "$favorites_file" 2>/dev/null | fzf --prompt="Select theme: " --height=40% --border)
    else
      selected=$(tinty list | fzf --prompt="Select theme: " --height=40% --border)
    fi

    [[ -z "$selected" ]] && return 0
    tinty apply "$selected"
  }

  theme-favorite-add() {
    local current_scheme_file="${XDG_DATA_HOME:-$HOME/.local/share}/tinted-theming/tinty/current_scheme"
    local favorites_file="${XDG_CONFIG_HOME:-$HOME/.config}/tinted-theming/tinty/favorites"
    [[ ! -f "$current_scheme_file" ]] && echo "No current theme set." && return 1
    local current="$(<"$current_scheme_file")"
    [[ ! -f "$favorites_file" ]] && touch "$favorites_file"
    if grep -qxF "$current" "$favorites_file"; then
      echo "$current is already in favorites."
      return 0
    fi
    echo "$current" >> "$favorites_file"
    sort -o "$favorites_file" "$favorites_file"
    echo "Added $current to favorites."
  }

  theme-favorite-remove() {
    local current_scheme_file="${XDG_DATA_HOME:-$HOME/.local/share}/tinted-theming/tinty/current_scheme"
    local favorites_file="${XDG_CONFIG_HOME:-$HOME/.config}/tinted-theming/tinty/favorites"
    [[ ! -f "$current_scheme_file" ]] && echo "No current theme set." && return 1
    local current="$(<"$current_scheme_file")"
    [[ ! -f "$favorites_file" ]] && echo "No favorites file found." && return 1
    if ! grep -qxF "$current" "$favorites_file"; then
      echo "$current is not in favorites."
      return 0
    fi
    local tmpfile
    tmpfile="$(mktemp)"
    grep -vxF "$current" "$favorites_file" > "$tmpfile" && mv "$tmpfile" "$favorites_file"
    echo "Removed $current from favorites."
  }
fi
