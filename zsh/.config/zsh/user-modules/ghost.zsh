#!/usr/bin/env zsh

function ghost() {
  local -a colors=($'\e[91m' $'\e[93m' $'\e[96m' $'\e[95m')
  local gc=${colors[$((RANDOM % 4 + 1))]}
  local wc=$'\e[97m'
  local rc=$'\e[0m'
  printf '\n'
  printf '%s           ░░░░░░░░%s\n'                                "$gc" "$rc"
  printf '%s       ░░░░░░░░░░░░░░░░%s\n'                            "$gc" "$rc"
  printf '%s     ░░░░░░░░░░░░░░░░░░░░%s\n'                          "$gc" "$rc"
  printf '%s   ░░░░░░    ░░░░░░░░    ░░%s\n'                        "$gc" "$rc"
  printf '%s   ░░░░        ░░░░        %s\n'                        "$gc" "$rc"
  printf '%s   ░░░░    %s▒▒▒▒%s░░░░    %s▒▒▒▒%s\n'                 "$gc" "$wc" "$gc" "$wc" "$rc"
  printf '%s ░░░░░░    %s▒▒▒▒%s░░░░    %s▒▒▒▒%s░░%s\n'             "$gc" "$wc" "$gc" "$wc" "$gc" "$rc"
  printf '%s ░░░░░░░░    ░░░░░░░░    ░░░░%s\n'                      "$gc" "$rc"
  printf '%s ░░░░░░░░░░░░░░░░░░░░░░░░░░░░%s\n'                      "$gc" "$rc"
  printf '%s ░░░░░░░░░░░░░░░░░░░░░░░░░░░░%s\n'                      "$gc" "$rc"
  printf '%s ░░░░░░░░░░░░░░░░░░░░░░░░░░░░%s\n'                      "$gc" "$rc"
  printf '%s ░░░░  ░░░░░░    ░░░░░░  ░░░░%s\n'                      "$gc" "$rc"
  printf '%s ░░      ░░░░    ░░░░      ░░%s\n'                      "$gc" "$rc"
  printf '\n'
}
