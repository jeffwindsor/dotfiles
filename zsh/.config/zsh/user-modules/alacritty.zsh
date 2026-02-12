#!/usr/bin/env zsh

# Alacritty theme switcher using fzf
function alacritty-theme() {
	local themes_dir="$HOME/.config/alacritty/themes"
	local config_file="$HOME/.config/alacritty/alacritty.toml"

	# Check if themes directory exists
	if [[ ! -d "$themes_dir" ]]; then
		echo "Error: Themes directory not found at $themes_dir"
		return 1
	fi

	# Get list of theme files (basename only, without .toml extension)
	local themes=($(ls "$themes_dir"/*.toml 2>/dev/null | xargs -n1 basename | sed 's/\.toml$//'))

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

	if grep -q "^import = " "$config_file"; then
		# Replace existing import line
		sed -i.bak "s|^import = .*|$import_line|" "$config_file"
	else
		# Add import line at the top after any existing comments
		local temp_file=$(mktemp)
		awk -v import="$import_line" '
			BEGIN { added=0 }
			/^[^#]/ && !added { print "# Import theme"; print import; print ""; added=1 }
			{ print }
		' "$config_file" > "$temp_file"
		mv "$temp_file" "$config_file"
	fi

	echo "✓ Switched Alacritty theme to: $selected_theme"
	echo "  (Alacritty will automatically reload the config)"
}

alias theme='alacritty-theme'
