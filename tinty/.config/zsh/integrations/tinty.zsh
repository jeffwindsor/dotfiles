#!/usr/bin/env zsh
# tinty — wrapper so 'tinty apply/init' propagates tinted-shell ANSI vars to the live shell
if command -v tinty &>/dev/null; then
  tinty() {
    command tinty "$@"
    if [[ "$1" == "apply" || "$1" == "init" ]]; then
      local data_dir="${XDG_DATA_HOME:-$HOME/.local/share}/tinted-theming/tinty"
      while IFS= read -r -d '' script; do
        source "$script"
      done < <(/usr/bin/find "$data_dir" -name "*.sh" -newer "$data_dir/current_scheme" -print0)
    fi
  }

  local -a _tinty_favorites=(
    base16-0x96f
    base24-0x96f
    base16-catppuccin-mocha
    base24-catppuccin-mocha
    base24-challenger-deep
    base16-everforest-dark-hard
    base16-kanagawa
    base16-nord
    base16-oceanicnext
    base16-material-palenight
    base16-papercolor-light
    base24-papercolor-light
    base16-rose-pine
    base16-rose-pine-moon
    base16-selenized-dark
    base16-tender
    base16-tokyo-night-dark
    base24-tokyo-night-dark
  )

  theme() {
    local mode
    mode=$(printf 'Favorites\nAll Themes\n' | fzf --prompt="Theme source: " --height=15% --border)
    [[ -z "$mode" ]] && return 0

    local selected
    if [[ "$mode" == "Favorites" ]]; then
      selected=$(printf '%s\n' "${_tinty_favorites[@]}" | fzf --prompt="Select theme: " --height=40% --border)
    else
      selected=$(tinty list | fzf --prompt="Select theme: " --height=40% --border)
    fi

    [[ -z "$selected" ]] && return 0
    tinty apply "$selected"
  }
fi
