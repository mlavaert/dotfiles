#!/bin/sh

xrdb ~/.Xresources 

dunst &
picom --no-fading-openclose --daemon &
redshift &
slstatus &
unclutter &
volumeicon &

feh --no-fehbg --bg-fill ~/.config/wall.png

export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit
wmname LG3D
