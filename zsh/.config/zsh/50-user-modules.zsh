#!/usr/bin/env zsh
# Load user modules (sourced in order alphabetically)

for f in "$XDG_CONFIG_HOME/zsh/user-modules"/*.zsh; do
  [[ -f "$f" ]] && source "$f"
done

setopt extended_glob

function sync(){
  setopt local_options no_monitor no_notify
  local dir=$(mktemp -d) start=$SECONDS failed=0 tty=0 drawn=0 frame=0 running i t icon name
  local -a names pids spin=(⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏)
  local -A code fin last
  # strip color/cursor escapes; keep only the final state of \r progress redraws
  local strip=$'s/\x1b\\[[0-9;?]*[a-zA-Z]//g; s/.*\r//'
  [[ -t 1 ]] && tty=1

  # 1) pull first: it reloads zshrc, so later steps see the latest config
  (( $+functions[dots-pull] )) && { dots-pull || failed=1 }

  print_section "Installs and Upgrades"
  # 2) slow and independent installers run in parallel; each job writes its exit code to <name>.rc when done; that file is the "finished" signal
  (( $+functions[sync-brew] ))   && { ( sync-brew   &>"$dir/brew.log";   print $? >"$dir/brew.rc" )   & names+=(brew)   pids+=($!) }
  (( $+functions[sync-fedora] )) && { ( sync-fedora &>"$dir/fedora.log"; print $? >"$dir/fedora.rc" ) & names+=(fedora) pids+=($!) }
  (( $+functions[sync-mise] ))   && { ( sync-mise   &>"$dir/mise.log";   print $? >"$dir/mise.rc" )   & names+=(mise)   pids+=($!) }
  (( $+functions[sync-zinit] ))  && { ( sync-zinit  &>"$dir/zinit.log";  print $? >"$dir/zinit.rc" )  & names+=(zinit)  pids+=($!) }
  (( $+functions[sync-tinty] ))  && { ( sync-tinty  &>"$dir/tinty.log";  print $? >"$dir/tinty.rc" )  & names+=(tinty)  pids+=($!) }

  {
    (( tty )) && printf '\e[?25l'
    while true; do
      running=0
      for name in $names; do
        [[ -n ${code[$name]} ]] && continue
        if [[ -s "$dir/$name.rc" ]]; then
          code[$name]=$(<"$dir/$name.rc")
          fin[$name]=$SECONDS
          (( ${code[$name]} )) && failed=1
          if (( ! tty )); then
            (( ${code[$name]} )) && icon=✗ || icon=✓
            printf '%s %s %ss\n' $icon $name $(( SECONDS - start ))
          fi
        else
          running=$(( running + 1 ))
        fi
      done

      if (( tty )); then
        (( drawn )) && printf '\e[%dA' ${#names}
        drawn=1
        (( frame = (frame + 1) % 10 ))
        for name in $names; do
          (( frame == 0 || ! running )) && last[$name]=$(sed -E "$strip" "$dir/$name.log" 2>/dev/null | grep -v '^[[:space:]]*$' | tail -n 1)
          if [[ -z ${code[$name]} ]]; then
            icon=$'\e[36m'${spin[frame+1]}$'\e[0m'
            t=$(( SECONDS - start ))
          else
            (( ${code[$name]} )) && icon=$'\e[31m✗\e[0m' || icon=$'\e[32m✓\e[0m'
            t=$(( ${fin[$name]} - start ))
          fi
          printf '\e[K%s %-6s %3ss  \e[90m%s\e[0m\n' $icon $name $t "${last[$name]:0:$(( COLUMNS - 20 ))}"
        done
      fi

      (( running )) || break
      sleep 0.1
    done

    for name in $names; do
      (( ${code[$name]} )) || continue
      print_section "$name failed (exit ${code[$name]})"
      sed -E "$strip" "$dir/$name.log"
    done
  } always {
    (( tty )) && printf '\e[?25h'
    rm -rf "$dir"
  }
  wait $pids 2>/dev/null

  # 3) link configs once the tools exist
  (( $+functions[sync-dots] )) && { sync-dots || failed=1 }

  # 4) reload last so the pulled and linked config takes effect
  print_section "Reloading ZSH"
  source ~/.zshrc
  return $failed
}
