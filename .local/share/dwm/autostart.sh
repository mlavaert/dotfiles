#!/bin/sh

xrdb ~/.Xresources 

dunst &
picom --no-fading-openclose --daemon &
redshift &
slstatus &
unclutter &
volumeicon &

feh --no-fehbg --bg-fill ~/.local/share/wallpaper.jpg

export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit
wmname LG3D
