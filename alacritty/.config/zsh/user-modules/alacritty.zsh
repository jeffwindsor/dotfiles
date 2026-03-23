#!/usr/bin/env zsh

# Alacritty theme switcher using fzf
function alacritty-theme() {
	local themes_dir="$HOME/.config/alacritty/themes"
	local config_file=$(realpath "$HOME/.config/alacritty/alacritty.toml")

	# Get list of theme files using fd
	local themes=($(fd --type f --extension toml --exec basename {} .toml \; . "$themes_dir" 2>/dev/null))

	if [[ ${#themes[@]} -eq 0 ]]; then
		echo "Error: No theme files found in $themes_dir"
		return 1
	fi

	# Use fzf to select a theme
	local selected_theme=$(printf '%s\n' "${themes[@]}" | fzf --prompt="Select Alacritty theme: " --height=40% --border)

	if [[ -z "$selected_theme" ]]; then
		echo "No theme selected"
		return 0
	fi

	sed -i.bak 's|.*~/.config/alacritty/themes/[^"]*\.toml.*|'"import = [\"~/.config/alacritty/themes/${selected_theme}.toml\"]"'|' "$config_file"

	echo "Alacritty theme: $selected_theme (Alacritty will automatically reload the config)"
}

alias theme='alacritty-theme'
