#!/usr/bin/env zsh

function qubert() {
  local -a colors=($'\e[91m' $'\e[92m' $'\e[93m' $'\e[94m' $'\e[95m' $'\e[96m')
  local c=${colors[$((RANDOM % 6 + 1))]}
  local w=$'\e[97m'
  local r=$'\e[0m'
  printf '\n'
  printf '%s           ░░░░░░░░%s\n'                    "$c" "$r"
  printf '%s       ░░░░░░░░░░░░░░░░%s\n'                "$c" "$r"
  printf '%s     ░░░░░░%s▒▒▒▒%s░░░░%s▒▒▒▒%s\n'          "$c" "$w" "$c" "$w" "$r"
  printf '%s   ░░░░░░░░    ░░░░    %s\n'                "$c" "$r"
  printf '%s   ░░░░░░░░    ░░░░    ░░%s\n'              "$c" "$r"
  printf '%s   ░░░░░░░░░░░░░░░░░░░░░░░░░░%s\n'         "$c" "$r"
  printf '%s   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░%s\n'       "$c" "$r"
  printf '%s   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░%s\n'     "$c" "$r"
  printf '%s     ░░░░░░░░░░░░░░░░  ░░░░    ░░%s\n'     "$c" "$r"
  printf '%s       ░░░░░░░░░░░░      ░░    ░░%s\n'     "$c" "$r"
  printf '%s         ░░░░░░░░░░        ░░░░%s\n'       "$c" "$r"
  printf '%s         ░░░    ░░░%s\n'                   "$c" "$r"
  printf '%s         ░░░    ░░░%s\n'                   "$c" "$r"
  printf '%s         ░░░    ░░░%s\n'                   "$c" "$r"
  printf '%s       ░░░░░░░  ░░░░░░░░░%s\n'             "$c" "$r"
  printf '%s         ░░░░░░      ░░░░░%s\n'            "$c" "$r"
  printf '\n'
}
