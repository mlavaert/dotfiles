# Setup PATH

export EDITOR="vim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export READER="zathura"

export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoreboth
shopt -s histappend

export JAVA_HOME="/usr/lib/jvm/default"

export npm_config_prefix=${HOME}/.node_modules

export PYENV_ROOT="${HOME}/.pyenv"
export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

export AWS_DEFAULT_REGION=eu-west-1

# Ranger
export RANGER_LOAD_DEFAULT_RC=FALSE

source ~/.bashrc.d/.path.bash

# Setup pyenv
if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init - )"
	eval "$(pyenv virtualenv-init - )"
fi
