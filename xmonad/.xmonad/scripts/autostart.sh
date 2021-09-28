#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

# dual monitor
xrandr --output eDP-1 --mode 1920x1080 --pos 0x1080 --rotate normal --output HDMI-1 --primary --mode 3840x2160 --pos 1920x0 --rotate normal --output DP-1 --off --output HDMI-2 --off

# polybar 
(sleep 2; run $HOME/.xmonad/polybar/launch.sh) &

# cursor active at boot
xsetroot -cursor_name left_ptr &

# wallpaper
feh --bg-fill /usr/share/backgrounds/arcolinux/arco-login-plasma.jpg &

#starting utility applications at boot time
#run variety &
#run nm-applet &
#run pamac-tray &
run xfce4-power-manager &
#run volumeicon &
#numlockx on &
#blueberry-tray &
picom --config $HOME/.xmonad/scripts/picom.conf &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
