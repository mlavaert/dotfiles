#!/usr/bin/env zsh

# paths
typeset -gU cdpath fpath mailpath path
path=( $XDG_BIN_HOME  $path )
fpath=( $XDG_BIN_HOME $fpath )

export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="brave"
export READER="mupdf"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_CACHE="$XDG_CACHE_HOME/zsh"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_BIN_HOME="$HOME/.local/bin"

# Create XDG Directories if they do not exist
for dir in "$XDG_CACHE_HOME" "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_BIN_HOME"; do
	[[ -d $dir ]]  || mkdir -p "$dir"
done
