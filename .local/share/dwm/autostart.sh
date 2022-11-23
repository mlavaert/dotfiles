#!/usr/bin/env bash
set -euo pipefail

xrdb ~/.Xresources

run() {
    if ! pgrep $1 ;
    then
        $@&
    else
        echo "=> $1 already running"
    fi
}

# Run background applications
run "dunst"
run "dbus-daemon --session"
run "redshift"
run "zscaler"
run "xfce4-power-manager"
run "slstatus"

autorandr --change

# Set wallpaper
feh --no-fehbg --bg-fill ~/.config/wall.png
