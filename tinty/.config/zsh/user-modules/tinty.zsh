#!/usr/bin/env zsh
if command -v tinty &>/dev/null; then
  THEME_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/tinted-theming/tinty"
  THEME_STATE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/tinted-theming/tinty"
  THEME_FAVORITES_FILE="$THEME_CONFIG_DIR/favorites"
  THEME_CURRENT_SCHEME="$THEME_STATE_DIR/current_scheme"

  theme-sync()  { tinty sync }
  alias theme=tinty-theme-tv

  # Resolve a short theme name to its full tinty id: base24 preferred, then base16, then any other prefix
  _tinty-resolve() {
    local name="$1" actual_list="$2"
    if   echo "$actual_list" | grep -qx "base24-$name"; then echo "base24-$name"
    elif echo "$actual_list" | grep -qx "base16-$name"; then echo "base16-$name"
    else echo "$actual_list" | grep -m1 "^[^-]*-${name}$"
    fi
  }

  tinty-theme-tv() {

    # validate tinty is installed
    [[ ! -d "$THEME_STATE_DIR" ]] && echo "$THEME_STATE_DIR does not exist. Run tinty sync." && return 1

    local actual_list; actual_list=$(tinty list)

    # look up the theme name resolving names without base prefix
    if [[ -n "$1" ]]; then
      local resolved; resolved=$(_tinty-resolve "$1" "$actual_list")
      [[ -z "$resolved" ]] && echo "Theme not found: $1" && return 1
      tinty apply "$resolved"; return
    fi

    local simplified_list=$(echo "$actual_list" | sed 's/^[^-]*-//' | sort -u)
    local simplified_favorites=$(sed 's/^[^-]*-/* /' "$THEME_FAVORITES_FILE" 2>/dev/null)
    local selected=$(printf '%s\n' "$simplified_favorites" "$simplified_list" | tv --no-sort --no-preview --input-prompt="Select theme: ")
    [[ -z "$selected" ]] && return 0
    local name=${selected#* }
    local resolved=$(_tinty-resolve "$name" "$actual_list")
    [[ -z "$resolved" ]] && echo "Theme not found: $name" && return 1
    tinty apply "$resolved"
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
