#!/bin/sh

xrandr -s 1920x1080
xrdb ~/.Xresources 

dunst &
slstatus &
unclutter &
volumeicon &
picom --no-fading-openclose --daemon &

feh --no-fehbg --bg-fill ~/.local/share/wallpaper.jpg

export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit
wmname LG3D
