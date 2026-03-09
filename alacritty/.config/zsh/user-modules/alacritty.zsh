#!/usr/bin/env zsh

# Alacritty theme switcher using fzf
function alacritty-theme() {
	local themes_dir="$HOME/.config/alacritty/themes"
	local config_file="$HOME/.config/alacritty/alacritty.toml"

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

	# Update the config file with the new theme
	local import_line="import = [\"~/.config/alacritty/themes/${selected_theme}.toml\"]"

	# Replace or append import line (assumes it's always the last line)
	if tail -1 "$config_file" | rg -q "^[[:space:]]*import = "; then
		sed -i.bak '$ s|.*|'"$import_line"'|' "$config_file"
	else
		echo "$import_line" >> "$config_file"
	fi

	echo "✓ Switched Alacritty theme to: $selected_theme"
	echo "  (Alacritty will automatically reload the config)"
}

alias theme='alacritty-theme'
