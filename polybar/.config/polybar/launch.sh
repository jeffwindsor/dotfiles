#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# load bars
desktop=$(echo $DESKTOP_SESSION)
count=$(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l)
if [ $count = 1 ]; then
  m=$(xrandr --query | grep " connected" | cut -d" " -f1)
  MONITOR=$m polybar --reload topbar -c ~/.config/polybar/config &
  #MONITOR=$m polybar --reload bottombar -c ~/.config/polybar/config &
else
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload topbar -c ~/.config/polybar/config &
    #MONITOR=$m polybar --reload bottombar -c ~/.config/polybar/config &
  done
fi
