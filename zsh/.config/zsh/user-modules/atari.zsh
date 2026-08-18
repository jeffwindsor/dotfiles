#!/usr/bin/env zsh

function atari() {
  local -a colors=($'\e[91m' $'\e[92m' $'\e[93m' $'\e[94m' $'\e[95m' $'\e[96m')
  local c=${colors[$((RANDOM % 6 + 1))]}
  local r=$'\e[0m'
  printf '\n'
  printf '%s          ░░ ░░░░ ░░%s\n'               "$c" "$r"
  printf '%s          ░░ ░░░░ ░░%s\n'               "$c" "$r"
  printf '%s          ░░ ░░░░ ░░%s\n'               "$c" "$r"
  printf '%s          ░░ ░░░░ ░░%s\n'               "$c" "$r"
  printf '%s          ░░ ░░░░ ░░%s\n'               "$c" "$r"
  printf '%s          ░░ ░░░░ ░░%s\n'               "$c" "$r"
  printf '%s         ░░░ ░░░░ ░░░%s\n'              "$c" "$r"
  printf '%s        ░░░░ ░░░░ ░░░░%s\n'             "$c" "$r"
  printf '%s      ░░░░░  ░░░░  ░░░░░%s\n'           "$c" "$r"
  printf '%s    ░░░░     ░░░░     ░░░░%s\n'         "$c" "$r"
  printf '%s░░░░░        ░░░░        ░░░░░%s\n'     "$c" "$r"
  printf '%s░░░          ░░░░          ░░░%s\n'     "$c" "$r"
  printf '\n'
}
