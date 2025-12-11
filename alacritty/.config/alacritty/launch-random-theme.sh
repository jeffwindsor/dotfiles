#!/usr/bin/env bash
# Launch Alacritty with random theme

ALACRITTY_DIR="$HOME/.config/alacritty"

# Get all generated theme configs
configs=("$ALACRITTY_DIR"/alacritty*.toml)

# Check if theme configs were found
if [[ ${#configs[@]} -eq 0 ]]; then
  echo "ERROR: No theme configs found in $ALACRITTY_DIR" >&2
  echo "Run: ~/.config/alacritty/generate-theme-configs.sh" >&2
  exit 1
fi

# Randomly select a config
selected_config="${configs[RANDOM % ${#configs[@]}]}"
config_name=$(basename "$selected_config" .toml)
theme_name="${config_name#alacritty-}"

# Debug output (optional - comment out to silence)
echo "🎨 Selected theme: $theme_name" >&2

# Launch Alacritty with open -n (new instance) with selected config
if [[ $# -gt 0 ]]; then
  # With program arguments: use -e flag
  open -n /Applications/Alacritty.app --args \
    --config-file "$selected_config" \
    -e "$@"
else
  # No arguments: launch plain Alacritty (uses default shell)
  open -n /Applications/Alacritty.app --args \
    --config-file "$selected_config"
fi
