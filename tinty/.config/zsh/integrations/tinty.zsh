#!/usr/bin/env zsh
if command -v tinty &>/dev/null; then
  tinty-setup()  { tinty sync && theme }
  tinty-update() { tinty sync && tinty init }

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
    local state_dir="${XDG_DATA_HOME:-$HOME/.local/share}/tinted-theming/tinty"
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
      selected=$(printf '%s\n' "${_tinty_favorites[@]}" | fzf --prompt="Select theme: " --height=40% --border)
    else
      selected=$(tinty list | fzf --prompt="Select theme: " --height=40% --border)
    fi

    [[ -z "$selected" ]] && return 0
    tinty apply "$selected"
  }
fi
