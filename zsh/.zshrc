#!/usr/bin/env zsh

#== PROFILE ==
# zmodload zsh/zprof
#=============

export TERM=xterm-256color
ZSH_CONFIG_DIR="${XDG_CONFIG_HOME}/zsh/"

# Load all modules in numbered order
for module in "${ZSH_CONFIG_DIR}"/*.zsh; do
  [[ -f "$module" ]] && source "$module"
done

# Load any machine specific configs
if [ -f $HOME/.zshrc.local ]; then
  source $HOME/.zshrc.local
fi

#== PROFILE ==
# zprof
#=============
_ghost_colors=($'\e[91m' $'\e[93m' $'\e[96m' $'\e[95m')
_gc=${_ghost_colors[$((RANDOM % 4 + 1))]}
_wc=$'\e[97m'
_rc=$'\e[0m'
printf '\n'
printf '%s           ░░░░░░░░%s\n'                                "$_gc" "$_rc"
printf '%s       ░░░░░░░░░░░░░░░░%s\n'                            "$_gc" "$_rc"
printf '%s     ░░░░░░░░░░░░░░░░░░░░%s\n'                          "$_gc" "$_rc"
printf '%s   ░░░░░░    ░░░░░░░░    ░░%s\n'                        "$_gc" "$_rc"
printf '%s   ░░░░        ░░░░        %s\n'                        "$_gc" "$_rc"
printf '%s   ░░░░    %s▒▒▒▒%s░░░░    %s▒▒▒▒%s\n'                 "$_gc" "$_wc" "$_gc" "$_wc" "$_rc"
printf '%s ░░░░░░    %s▒▒▒▒%s░░░░    %s▒▒▒▒%s░░%s\n'             "$_gc" "$_wc" "$_gc" "$_wc" "$_gc" "$_rc"
printf '%s ░░░░░░░░    ░░░░░░░░    ░░░░%s\n'                      "$_gc" "$_rc"
printf '%s ░░░░░░░░░░░░░░░░░░░░░░░░░░░░%s\n'                      "$_gc" "$_rc"
printf '%s ░░░░░░░░░░░░░░░░░░░░░░░░░░░░%s\n'                      "$_gc" "$_rc"
printf '%s ░░░░░░░░░░░░░░░░░░░░░░░░░░░░%s\n'                      "$_gc" "$_rc"
printf '%s ░░░░  ░░░░░░    ░░░░░░  ░░░░%s\n'                      "$_gc" "$_rc"
printf '%s ░░      ░░░░    ░░░░      ░░%s\n'                      "$_gc" "$_rc"
printf '\n'
unset _ghost_colors _gc _wc _rc

