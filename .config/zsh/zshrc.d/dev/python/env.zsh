#!/usr/bin/env sh

export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$XDG_CACHE_HOME/pip

gpip() {
	PIP_REQUIRE_VIRTUALENV=false pip "$@"
}


# Load virtualenvwrapper
source $XDG_BIN_HOME/virtualenvwrapper_lazy.sh
