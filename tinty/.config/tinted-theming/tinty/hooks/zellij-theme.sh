#!/usr/bin/env bash
# Converts tinty Base24 hex palette to a Zellij KDL theme file.
# Env vars available: TINTY_SCHEME_PALETTE_BASE00_HEX_R/G/B .. (no # prefix)

set -euo pipefail

hex_to_rgb() {
  local h="${1#'#'}"
  printf "%d %d %d" "0x${h:0:2}" "0x${h:2:2}" "0x${h:4:2}"
}

get_hex() {
  local base="$1" r_def="$2" g_def="$3" b_def="$4"
  local r_var="TINTY_SCHEME_PALETTE_${base}_HEX_R"
  local g_var="TINTY_SCHEME_PALETTE_${base}_HEX_G"
  local b_var="TINTY_SCHEME_PALETTE_${base}_HEX_B"
  echo "${!r_var:-$r_def}${!g_var:-$g_def}${!b_var:-$b_def}"
}

BG=$(hex_to_rgb "$(get_hex BASE00 28 28 28)")
BG1=$(hex_to_rgb "$(get_hex BASE01 38 38 38)")
BG2=$(hex_to_rgb "$(get_hex BASE02 48 48 48)")
COMMENT=$(hex_to_rgb "$(get_hex BASE03 58 58 58)")
FG=$(hex_to_rgb "$(get_hex BASE05 d8 d8 d8)")
RED=$(hex_to_rgb "$(get_hex BASE08 ab 46 42)")
ORANGE=$(hex_to_rgb "$(get_hex BASE09 dc 96 56)")
YELLOW=$(hex_to_rgb "$(get_hex BASE0A f7 ca 88)")
GREEN=$(hex_to_rgb "$(get_hex BASE0B a1 b5 6c)")
CYAN=$(hex_to_rgb "$(get_hex BASE0C 86 c1 b9)")
BLUE=$(hex_to_rgb "$(get_hex BASE0D 7c af c2)")
PURPLE=$(hex_to_rgb "$(get_hex BASE0E ba 8b af)")

mkdir -p "${HOME}/.config/zellij/themes"

cat > "${HOME}/.config/zellij/themes/tinted-theming.kdl" <<EOF
themes {
    tinted-theming {
        text_unselected {
            base $FG
            background $BG
            emphasis_0 $BLUE
            emphasis_1 $GREEN
            emphasis_2 $YELLOW
            emphasis_3 $ORANGE
        }
        text_selected {
            base $FG
            background $BG1
            emphasis_0 $BLUE
            emphasis_1 $GREEN
            emphasis_2 $YELLOW
            emphasis_3 $ORANGE
        }
        ribbon_selected {
            base $BG
            background $BLUE
            emphasis_0 $COMMENT
            emphasis_1 $COMMENT
            emphasis_2 $COMMENT
            emphasis_3 $COMMENT
        }
        ribbon_unselected {
            base $FG
            background $BG2
            emphasis_0 $BLUE
            emphasis_1 $GREEN
            emphasis_2 $YELLOW
            emphasis_3 $ORANGE
        }
        table_title {
            base $GREEN
            background 0
            emphasis_0 $BLUE
            emphasis_1 $GREEN
            emphasis_2 $YELLOW
            emphasis_3 $ORANGE
        }
        table_cell_selected {
            base $FG
            background $BG1
            emphasis_0 $BLUE
            emphasis_1 $GREEN
            emphasis_2 $YELLOW
            emphasis_3 $ORANGE
        }
        table_cell_unselected {
            base $COMMENT
            background $BG
            emphasis_0 $BG2
            emphasis_1 $BG2
            emphasis_2 $BG2
            emphasis_3 $BG2
        }
        list_selected {
            base $FG
            background $BG1
            emphasis_0 $BLUE
            emphasis_1 $GREEN
            emphasis_2 $YELLOW
            emphasis_3 $ORANGE
        }
        list_unselected {
            base $FG
            background $BG
            emphasis_0 $BLUE
            emphasis_1 $GREEN
            emphasis_2 $YELLOW
            emphasis_3 $ORANGE
        }
        frame_selected {
            base $BLUE
            background 0
            emphasis_0 $BLUE
            emphasis_1 $GREEN
            emphasis_2 $YELLOW
            emphasis_3 $ORANGE
        }
        frame_highlight {
            base $YELLOW
            background 0
            emphasis_0 $BLUE
            emphasis_1 $GREEN
            emphasis_2 $YELLOW
            emphasis_3 $ORANGE
        }
        exit_code_success {
            base $GREEN
            background 0
            emphasis_0 $BLUE
            emphasis_1 $GREEN
            emphasis_2 $YELLOW
            emphasis_3 $ORANGE
        }
        exit_code_error {
            base $RED
            background 0
            emphasis_0 $BLUE
            emphasis_1 $GREEN
            emphasis_2 $YELLOW
            emphasis_3 $ORANGE
        }
        multiplayer_user_colors {
            player_1 $RED
            player_2 $BLUE
            player_3 0
            player_4 $GREEN
            player_5 $YELLOW
            player_6 0
            player_7 $CYAN
            player_8 0
            player_9 0
            player_10 0
        }
    }
}
EOF
