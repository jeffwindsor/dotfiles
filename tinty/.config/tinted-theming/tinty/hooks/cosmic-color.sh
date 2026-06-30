#!/usr/bin/env bash
# Updates COSMIC desktop accent color from the tinty Base16 palette.
# BASE0D (blue/primary) drives the accent used for window borders and UI highlights.
# No-op on machines where COSMIC is not installed/stowed.

set -euo pipefail

COSMIC_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/cosmic"
[[ -d "$COSMIC_DIR" ]] || exit 0

hex_to_float() {
    local dec=$((16#$1))
    awk "BEGIN { printf \"%.7f\", $dec / 255.0 }"
}

R=$(hex_to_float "${TINTY_SCHEME_PALETTE_BASE0D_HEX_R:-7c}")
G=$(hex_to_float "${TINTY_SCHEME_PALETTE_BASE0D_HEX_G:-af}")
B=$(hex_to_float "${TINTY_SCHEME_PALETTE_BASE0D_HEX_B:-c2}")

BUILDER="$COSMIC_DIR/com.system76.CosmicTheme.Dark.Builder/v1"
mkdir -p "$BUILDER"
printf 'Some((\n    red: %s,\n    green: %s,\n    blue: %s,\n))' "$R" "$G" "$B" > "$BUILDER/accent"
