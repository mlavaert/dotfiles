# Path 
typeset -gU path fpath mailpath cdpath
path=($XDG_BIN_HOME $HOME/.bin $HOME/.node_modules/bin $path)
fpath=($XDG_BIN_HOME $fpath)

function _is_interactive { [[ $- == *i* ]]; }
function _cache {
  _is_interactive || return 1
  local cache_dir="$XDG_CACHE_HOME/${SHELL##*/}"
  local cache="$cache_dir/$1"
  if [[ ! -f $cache || ! -s $cache ]]; then
    echo "Caching $1"
    mkdir -p $cache_dir
    "$@" >$cache
  fi
  source $cache
}


# Python
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
export GRADLE_USER_HOME="$XDG_CACHE_HOME/gradle"

# Golang
export GOPATH=$HOME/dev/go
export PATH=$PATH:$GOPATH/bin

# Aws
export AWS_PROFILE=masl
export AWS_DEFAULT_REGION=eu-west-1
export AWS_SDK_LOAD_CONFIG=1

# Node

export NPM_CONFIG_PREFIX=${HOME}/.node_module

# XDG Specification
export PSQL_HISTORY=$XDG_CACHE_HOME/pg/psql_history
export CARGO_HOME="$XDG_DATA_HOME"/cargo
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



