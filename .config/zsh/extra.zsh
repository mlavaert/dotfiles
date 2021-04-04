#!/usr/bin/env zsh
export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$XDG_CACHE_HOME/pip
export IPYTHONDIR=$XDG_CONFIG_HOME/jupyter
export JUPYTER_CONFIG_DIR=$XDG_CONFIG_HOME/jupyter

export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
path=( $PYENV_ROOT/bin $path )

eval "$(pyenv init - --no-rehash)"
eval "$(pyenv virtualenv-init -)"

# Java
export JAVA_HOME="/usr/lib/jvm/default"

# Golang
export GOPATH=$HOME/dev/go
path=( $PATH:$GOPATH/bin $path)

# Aws
export AWS_PROFILE=masl
export AWS_DEFAULT_REGION=eu-west-1
export AWS_SDK_LOAD_CONFIG=1

# XDG Specification
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/config
export LESSKEY=$XDG_CONFIG_HOME/less/lesskey
export LESSHISTFILE=$XDG_CACHE_HOME/less/history
export DOCKER_CONFIG=$XDG_CONFIG_HOME/docker

# Utility functions
function bw-unlock() {
    export BW_SESSION=$(bw unlock --raw)
}

function gpip() {
    PIP_REQUIRE_VIRTUALENV=false pip "$@"
}

function kcluster() {
    local cluster=`aws eks list-clusters --output text | awk '{print $2}' | fzf`
    aws eks update-kubeconfig --name "$cluster"
}

function kssh() {
    local pod=`kubectl get pods "$@" | awk '/Running/ {print $1}' | fzf`
    kubectl exec -it "$@" ${pod} bash
}
