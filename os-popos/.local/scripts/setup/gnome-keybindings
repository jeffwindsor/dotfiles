#!/usr/bin/env bash

################################################################################
# POP-OS KEYBINDINGS
################################################################################
set -e
cd "$(dirname "${0}")"

echo-color(){ printf "\033[0;32m==> $1 \033[0m \n"; }
MEDIA_KEYS='/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings' 

addCustom(){
    dconf write "$MEDIA_KEYS/custom$1/binding" "$2"
    dconf write "$MEDIA_KEYS/custom$1/command" "$3"
    dconf write "$MEDIA_KEYS/custom$1/name" "$4"
}

echo-color "POP-OS KEYBINDINGS"

echo-color "Launchers" 
dconf write '/org/gnome/settings-daemon/plugins/media-keys/terminal' "['<Super>Return']"
dconf write '/org/gnome/settings-daemon/plugins/media-keys/www' "['<Ctrl><Super>Return']"
dconf write '/org/gnome/settings-daemon/plugins/media-keys/control-center' "['<Super>comma']"
dconf write '/org/gnome/settings-daemon/plugins/media-keys/home' "['<Shift><Super>Return']"

echo-color "Move, resize, and swap windows"
dconf write '/org/gnome/shell/extensions/pop-shell/tile-enter' "@as ['<Super>w']"

echo-color "Navigate applications and windows"
dconf write '/org/gnome/shell/extensions/pop-shell/activate-launcher' "['<Super>space']"

echo-color "Navigation"
dconf write "/org/gnome/desktop/wm/keybindings/move-to-monitor-left" "['<Shift><Ctrl><Super>Left', '<Shift><Ctrl><Super>h']"
dconf write "/org/gnome/desktop/wm/keybindings/move-to-monitor-right" "['<Shift><Ctrl><Super>Right', '<Shift><Ctrl><Super>l']"
dconf write "/org/gnome/desktop/wm/keybindings/move-to-workspace-up" "['<Shift><Ctrl><Super>Up', '<Shift><Ctrl><Super>k']"
dconf write "/org/gnome/desktop/wm/keybindings/move-to-workspace-down" "['<Shift><Ctrl><Super>Down', '<Shift><Ctrl><Super>j']"

dconf write "/org/gnome/mutter/dynamic-workspaces" "false"
dconf write "/org/gnome/desktop/wm/preferences/num-workspaces" "9"

dconf write "/org/gnome/desktop/wm/keybindings/move-to-workspace-1" "['<Shift><Super>1']"
dconf write "/org/gnome/desktop/wm/keybindings/move-to-workspace-2" "['<Shift><Super>2']"
dconf write "/org/gnome/desktop/wm/keybindings/move-to-workspace-3" "['<Shift><Super>3']"
dconf write "/org/gnome/desktop/wm/keybindings/move-to-workspace-4" "['<Shift><Super>4']"

dconf write "/org/gnome/desktop/wm/keybindings/switch-to-workspace-1" "['<Super>1']"
dconf write "/org/gnome/desktop/wm/keybindings/switch-to-workspace-2" "['<Super>2']"
dconf write "/org/gnome/desktop/wm/keybindings/switch-to-workspace-3" "['<Super>3']"
dconf write "/org/gnome/desktop/wm/keybindings/switch-to-workspace-4" "['<Super>4']"
dconf write "/org/gnome/desktop/wm/keybindings/switch-to-workspace-5" "['<Super>5']"
dconf write "/org/gnome/desktop/wm/keybindings/switch-to-workspace-6" "['<Super>6']"
dconf write "/org/gnome/desktop/wm/keybindings/switch-to-workspace-7" "['<Super>7']"
dconf write "/org/gnome/desktop/wm/keybindings/switch-to-workspace-8" "['<Super>8']"
dconf write "/org/gnome/desktop/wm/keybindings/switch-to-workspace-9" "['<Super>9']"
dconf write "/org/gnome/desktop/wm/keybindings/switch-to-workspace-last" "@as []"

dconf write "/org/gnome/desktop/wm/keybindings/switch-applications-backward" "['<Shift><Super>Tab']"
dconf write "/org/gnome/desktop/wm/keybindings/switch-applications" "['<Super>Tab']"

dconf write "/org/gnome/desktop/wm/keybindings/cycle-applications-backward" "['<Shift><Alt><Super>Tab']"
dconf write "/org/gnome/desktop/wm/keybindings/cycle-applications" "['<Alt><Super>Tab']"

echo-color "System"
dconf write "/org/gnome/shell/keybindings/toggle-application-view" "['<Alt><Super>space']"
dconf write "/org/gnome/shell/keybindings/toggle-message-tray" "['<Shift><Super>n']"
dconf write "/org/gnome/desktop/wm/keybindings/panel-main-menu" "['<Alt>F1', '<Alt>equal']"
dconf write "/org/gnome/desktop/wm/keybindings/panel-run-dialog" "['<Alt>F2', '<Primary><Alt><Super>space']"

echo-color "Create Custom Keybinding entries"
dconf write "$MEDIA_KEYS" "['$MEDIA_KEYS/custom0/','$MEDIA_KEYS/custom1/','$MEDIA_KEYS/custom2/','$MEDIA_KEYS/custom3/','$MEDIA_KEYS/custom4/','$MEDIA_KEYS/custom5/']"

echo-color "Emacs - remove email short cut to eliminate overlap"
dconf write '/org/gnome/settings-daemon/plugins/media-keys/email' '@as []'
addCustom "0" "['<Super>e']" "'emacs'" "'Launch Emacs'"

echo-color "VSCode"
addCustom "1" "'<Super><Shift>e'" "'code'" "'Launch VSCodium'"

echo-color "Intellij"
addCustom "2" "'<Super>i'" "'idea'" "'Launch Intellij Idea'"

echo-color "Tweaks"
addCustom "3" "'<Super>period'" "'Gnome Tweaks'" "'Launch Gnome Tweaks'"

echo-color "Logout"
addCustom "4" "'<Super><Ctrl>x'" "'gnome-session-quit'" "'Logout'"

echo-color "Tweaks"
addCustom "5" "'<Super><Shift>x'" "'reboot'" "'Restart'"
