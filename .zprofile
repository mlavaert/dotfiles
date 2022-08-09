#!/usr/bin/env zsh
export EDITOR="nvim"
export TERMINAL="xterm"
export BROWSER="firefox"

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_BIN_HOME="$HOME/.local/bin"

export ZSH_CACHE="$XDG_CACHE_HOME/zsh"
export ZGEN_DIR="$XDG_DATA_HOME/zsh"
export ZGEN_SOURCE="$ZGEN_DIR/zgen.zsh"

# Create XDG Directories if they do not exist
for dir in "$XDG_CACHE_HOME" "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_BIN_HOME" "$ZSH_CACHE"; do
    [[ -d $dir ]]  || mkdir -p "$dir"
done

# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx
