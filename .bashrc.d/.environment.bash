export EDITOR="vim"
export TERMINAL="xterm"
export BROWSER="firefox"
export READER="zathura"

export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoreboth
shopt -s histappend

# Java
export JAVA_HOME="/usr/lib/jvm/default"

# Node Global packages installed in $HOME/.node_modules
export npm_config_prefix=${HOME}/.node_modules

# Python 
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PYENV_ROOT="${HOME}/.pyenv"
export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

# Ranger
export RANGER_LOAD_DEFAULT_RC=FALSE
