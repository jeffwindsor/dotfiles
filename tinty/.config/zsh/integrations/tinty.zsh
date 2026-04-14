#!/usr/bin/env zsh
if command -v tinty &>/dev/null; then
  THEME_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/tinted-theming/tinty"
  THEME_STATE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/tinted-theming/tinty"
  THEME_FAVORITES_FILE="$THEME_CONFIG_DIR/favorites"
  THEME_CURRENT_SCHEME="$THEME_STATE_DIR/current_scheme"

  theme-sync()  { tinty sync }

  theme() {
    if [[ ! -d "$THEME_STATE_DIR" ]]; then
      echo "$THEME_STATE_DIR does not exist. Run theme-sync first then try theme again."
      return 1
    fi

    if [[ -n "$1" ]]; then
      local all selected
      all=$(tinty list)
      if echo "$all" | grep -qx "base24-$1"; then
        selected="base24-$1"
      elif echo "$all" | grep -qx "base16-$1"; then
        selected="base16-$1"
      else
        echo "Theme not found: base24-$1 or base16-$1"
        return 1
      fi
      tinty apply "$selected"
      return
    fi

    local mode
    mode=$(printf 'Favorites\nAll Themes\n' | fzf --prompt="Theme source: " --height=15% --border)
    [[ -z "$mode" ]] && return 0

    local selected
    if [[ "$mode" == "Favorites" ]]; then
      selected=$(cat "$THEME_FAVORITES_FILE" 2>/dev/null | fzf --prompt="Select theme: " --height=40% --border)
    else
      selected=$(tinty list | fzf --prompt="Select theme: " --height=40% --border)
    fi

    [[ -z "$selected" ]] && return 0
    tinty apply "$selected"
  }

  theme-favorite() {
    [[ ! -f "$THEME_CURRENT_SCHEME" ]] && echo "No current theme set." && return 1
    local current="$(<"$THEME_CURRENT_SCHEME")"
    [[ ! -f "$THEME_FAVORITES_FILE" ]] && touch "$THEME_FAVORITES_FILE"
    if grep -qxF "$current" "$THEME_FAVORITES_FILE"; then
      echo "$current is already in favorites."
      return 0
    fi
    echo "$current" >> "$THEME_FAVORITES_FILE"
    sort -o "$THEME_FAVORITES_FILE" "$THEME_FAVORITES_FILE"
    echo "Added $current to favorites."
  }

  theme-unfavorite() {
    [[ ! -f "$THEME_CURRENT_SCHEME" ]] && echo "No current theme set." && return 1
    local current="$(<"$THEME_CURRENT_SCHEME")"
    [[ ! -f "$THEME_FAVORITES_FILE" ]] && echo "No favorites file found." && return 1
    if ! grep -qxF "$current" "$THEME_FAVORITES_FILE"; then
      echo "$current is not in favorites."
      return 0
    fi
    local tmpfile
    tmpfile="$(mktemp)"
    grep -vxF "$current" "$THEME_FAVORITES_FILE" > "$tmpfile" && mv "$tmpfile" "$THEME_FAVORITES_FILE"
    echo "Removed $current from favorites."
  }

  theme-list() {
    [[ ! -f "$THEME_FAVORITES_FILE" ]] && echo "No favorites file found." && return 1
    echo "Favorite Themes:"
    cat "$THEME_FAVORITES_FILE"
  }
fi
