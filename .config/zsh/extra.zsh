# Path 
typeset -gU path fpath mailpath cdpath
path=($XDG_BIN_HOME $HOME/.bin $HOME/.node_modules/bin $path)
fpath=($XDG_BIN_HOME $fpath)

# Python
export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$XDG_CACHE_HOME/pip

source $XDG_BIN_HOME/virtualenvwrapper_lazy.sh


# Java
export JAVA_HOME="/usr/lib/jvm/default"
export GRADLE_USER_HOME="$XDG_CACHE_HOME/gradle"


# Aws
export AWS_PROFILE=masl
export AWS_DEFAULT_REGION=eu-west-1
export AWS_SDK_LOAD_CONFIG=1


# Node
export NPM_CONFIG_PREFIX=${HOME}/.node_module
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/config


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
