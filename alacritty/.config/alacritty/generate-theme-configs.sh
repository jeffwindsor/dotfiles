#!/usr/bin/env bash
# Generate individual Alacritty config files for each theme

ALACRITTY_DIR="$HOME/.config/alacritty"
THEMES_DIR="$ALACRITTY_DIR/themes"
BASE_CONFIG="$ALACRITTY_DIR/alacritty.toml"

# Check if base config exists
if [[ ! -f "$BASE_CONFIG" ]]; then
  echo "ERROR: Base config not found: $BASE_CONFIG" >&2
  exit 1
fi

# Check if themes directory exists
if [[ ! -d "$THEMES_DIR" ]]; then
  echo "ERROR: Themes directory not found: $THEMES_DIR" >&2
  exit 1
fi

echo "🔨 Generating theme-specific configs..."

# For each theme file
for theme_file in "$THEMES_DIR"/*.toml; do
  theme_name=$(basename "$theme_file" .toml)
  output_config="$ALACRITTY_DIR/alacritty-${theme_name}.toml"

  # Create config that imports the theme
  cat >"$output_config" <<EOF
general.import = [
  "$theme_file"
]

EOF

  # Append the base config content
  cat "$BASE_CONFIG" >>"$output_config"

  echo "  ✅ Generated: alacritty-${theme_name}.toml"
done

echo ""
echo "🎉 Done! Generated $(ls "$ALACRITTY_DIR"/alacritty-*.toml 2>/dev/null | wc -l | tr -d ' ') theme configs"
