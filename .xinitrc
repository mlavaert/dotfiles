xrdb -merge ~/.Xresources 

dunst &
slstatus &
redshift &
unclutter &
volumeicon &
picom --no-fading-openclose --daemon &

feh --no-fehbg --bg-fill ~/.local/share/wallpaper.jpg

exec dwm
