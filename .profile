#!/usr/bin/env zsh

# paths
typeset -gU cdpath fpath mailpath path
path=( $XDG_BIN_HOME $HOME/.bin $HOME/.node_modules/bin  $path )
fpath=( $XDG_BIN_HOME $fpath )

export EDITOR="em -t"
export TERMINAL="alacritty"
export BROWSER="brave"
export READER="zathura"

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_BIN_HOME="$HOME/.local/bin"

for dir in "$XDG_CACHE_HOME" "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_BIN_HOME"; do
	[[ -d $dir ]]  || mkdir -p "$dir"
done

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_CACHE="$XDG_CACHE_HOME/zsh"

# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx
if [ -e /home/mlavaert/.nix-profile/etc/profile.d/nix.sh ]; then . /home/mlavaert/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
