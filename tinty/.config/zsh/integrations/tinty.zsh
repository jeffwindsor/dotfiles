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
    local name="$1" all="$2"
    if   echo "$all" | grep -qx "base24-$name"; then echo "base24-$name"
    elif echo "$all" | grep -qx "base16-$name"; then echo "base16-$name"
    else echo "$all" | grep -m1 "^[^-]*-${name}$"
    fi
  }

  tinty-theme-fzf() {
    [[ ! -d "$THEME_STATE_DIR" ]] && echo "$THEME_STATE_DIR does not exist. Run theme-sync first." && return 1
    local all; all=$(tinty list)

    if [[ -n "$1" ]]; then
      local resolved; resolved=$(_tinty-resolve "$1" "$all")
      [[ -z "$resolved" ]] && echo "Theme not found: $1" && return 1
      tinty apply "$resolved"; return
    fi

    local unique fav_shorts selected resolved
    unique=$(echo "$all" | sed 's/^[^-]*-//' | sort -u)
    fav_shorts=$(sed 's/^[^-]*-//' "$THEME_FAVORITES_FILE" 2>/dev/null)

    selected=$(
      {
        echo "$unique" | while IFS= read -r n; do echo "$fav_shorts" | grep -qx "$n" && echo "★ $n"; done
        echo "$unique" | while IFS= read -r n; do echo "$fav_shorts" | grep -qx "$n" || echo "$n"; done
      } | fzf --prompt="Select theme: " --height=100% --border --layout=reverse
    )
    [[ -z "$selected" ]] && return 0
    resolved=$(_tinty-resolve "${selected#★ }" "$all")
    [[ -z "$resolved" ]] && echo "Theme not found: ${selected#★ }" && return 1
    tinty apply "$resolved"
  }

  tinty-theme-tv() {
    [[ ! -d "$THEME_STATE_DIR" ]] && echo "$THEME_STATE_DIR does not exist. Run theme-sync first." && return 1
    local all; all=$(tinty list)

    if [[ -n "$1" ]]; then
      local resolved; resolved=$(_tinty-resolve "$1" "$all")
      [[ -z "$resolved" ]] && echo "Theme not found: $1" && return 1
      tinty apply "$resolved"; return
    fi

    local unique fav_shorts tmplist selected resolved
    unique=$(echo "$all" | sed 's/^[^-]*-//' | sort -u)
    fav_shorts=$(sed 's/^[^-]*-//' "$THEME_FAVORITES_FILE" 2>/dev/null)
    tmplist=$(mktemp)
    {
      echo "$unique" | while IFS= read -r n; do echo "$fav_shorts" | grep -qx "$n" && echo "* $n"; done
      echo "$unique" | while IFS= read -r n; do echo "$fav_shorts" | grep -qx "$n" || echo "$n"; done
    } > "$tmplist"

    selected=$(tv --no-sort --source-command="cat $tmplist" --input-prompt="Select theme: ")
    rm -f "$tmplist"
    [[ -z "$selected" ]] && return 0
    resolved=$(_tinty-resolve "${selected#* }" "$all")
    [[ -z "$resolved" ]] && echo "Theme not found: ${selected#* }" && return 1
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
