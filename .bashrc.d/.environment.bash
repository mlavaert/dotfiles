
export BROWSER=firefox
export EDITOR=vim

# Add PyEnv to PATH
export PATH="$HOME/.pyenv/bin:$PATH"

# Pip
export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

# Node Global packages installed in $HOME/.node_modules
export npm_config_prefix=${HOME}/.node_modules

# Python 3 requires these
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
