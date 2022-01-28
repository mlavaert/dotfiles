# plugins
[ -d "$ZGEN_DIR" ] || git clone https://github.com/tarjoilija/zgen "$ZGEN_DIR"
source "$ZGEN_SOURCE"

if ! zgen saved; then
  zgen load agkozak/zsh-z
  zgen load junegunn/fzf shell
  zgen load subnixr/minimal
  zgen load zdharma-continuum/fast-syntax-highlighting
  zgen save
fi


# ########
# Settings
# ########
WORDCHARS='_-*?[]~&.;!#$%^(){}<>' # Treat these characters as part of a word.

setopt RC_QUOTES          # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'
unsetopt BEEP             # Hush now, quiet now.

## History
HISTFILE="$XDG_CACHE_HOME/zsh/history"
HISTSIZE=4000                    # Max events to store in internal history.
SAVEHIST=4000                    # Max events to store in history file.

setopt BANG_HIST                 # Don't treat '!' specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt APPEND_HISTORY            # Appends history to history file on exit
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.

## Directories
setopt AUTO_CD              # Auto changes to a directory without typing cd.
setopt EXTENDED_GLOB        # Use extended globbing syntax.
unsetopt GLOB_DOTS

# autoload
autoload -Uz compinit edit-command-line
zmodload zsh/complist

typeset -gU path fpath
path=($XDG_BIN_HOME $HOME/.config/emacs/bin $path)
fpath=($XDG_BIN_HOME $fpath)

# completions
zstyle ':completion:*' menu select
_comp_options+=(globdots) # include hidden files

# On slow systems, checking the cached .zcompdump file to see if it must be 
# regenerated adds a noticable delay to zsh startup.  This little hack restricts 
# it to once a day.  It should be pasted into your own completion file.
#
# The globbing is a little complicated here:
# - '#q' is an explicit glob qualifier that makes globbing work within zsh's [[ ]] construct.
# - 'N' makes the glob pattern evaluate to nothing when it doesn't match (rather than throw a globbing error)
# - '.' matches "regular files"
# - 'mh+24' matches files (or directories or whatever) that are older than 24 hours.
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

## vi-mode
zle -N edit-command-line
bindkey '^ ' edit-command-line # Open current prompt in external editor

bindkey -v
bindkey -M viins 'jk' vi-cmd-mode

## Direnv
if [ -n $(which direnv) ]; then
        eval "$(direnv hook zsh)"
fi

## Aliases
if [ -n $(which doas) ]; then
	alias sudo=doas
fi

alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias willy="mpv https://playerservices.streamtheworld.com/api/livestream-redirect/WILLYAAC.AAC"

alias vim=nvim

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ll='ls -laF --color'
alias ls='ls --color'

alias mkdir='mkdir -p'

# aliases for tools
alias mk=make
alias tf=terraform
alias k=kubectl

please='sudo !!'

alias y='xclip -selection clipboard -in'
alias p='xclip -selection clipboard -out'

# Java
export JAVA_HOME="/usr/lib/jvm/default"

# XDG Specification
export PYENV_ROOT=$XDG_DATA_HOME/pyenv
export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$XDG_CACHE_HOME/pip
export IPYTHONDIR=$XDG_CONFIG_HOME/jupyter
export JUPYTER_CONFIG_DIR=$XDG_CONFIG_HOME/jupyter
export LESSKEY=$XDG_CONFIG_HOME/less/lesskey
export LESSHISTFILE=$XDG_CACHE_HOME/less/history
export DOCKER_CONFIG=$XDG_CONFIG_HOME/docker
export Z_DATA=$XDG_CACHE_HOME/z

# Utility functions
function bw-unlock() {
    export BW_SESSION=$(bw unlock --raw)
}
