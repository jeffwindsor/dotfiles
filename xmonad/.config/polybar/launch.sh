#!/usr/bin/env sh

# More info : https://github.com/jaagr/polybar/wiki
# pre-reqs  : # awesome-terminal-fonts

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

desktop=$(echo $DESKTOP_SESSION)
count=$(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l)

# top bar
if [ $count = 1 ]; then
  m=$(xrandr --query | grep " connected" | cut -d" " -f1)
  MONITOR=$m polybar --reload mainbar-xmonad -c ~/.config/polybar/config &
else
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload mainbar-xmonad -c ~/.config/polybar/config &
  done
fi

# second polybar at bottom
# if [ $count = 1 ]; then
#   m=$(xrandr --query | grep " connected" | cut -d" " -f1)
#   MONITOR=$m polybar --reload mainbar-xmonad-extra -c ~/.config/polybar/config &
# else
#   for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#     MONITOR=$m polybar --reload mainbar-xmonad-extra -c ~/.config/polybar/config &
#   done
# fi
