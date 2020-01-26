# Setup PATH
PATH="$PATH:$HOME/.bin"

export EDITOR="vim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export READER="zathura"

export JAVA_HOME="/usr/lib/jvm/default"
export NPM_CONFIG_PREFIX=${HOME}/.node_modules
export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$HOME/.cache/pip
export AWS_DEFAULT_REGION=eu-west-1

# Ranger
export RANGER_LOAD_DEFAULT_RC=FALSE

# Start graphical server on tty1 if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && exec startx
