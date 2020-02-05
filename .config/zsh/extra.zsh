export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$XDG_CACHE_HOME/pip

function gpip() {
	PIP_REQUIRE_VIRTUALENV=false pip "$@"
}


# Load virtualenvwrapper
source $XDG_BIN_HOME/virtualenvwrapper_lazy.sh


export JAVA_HOME="/usr/lib/jvm/default"
export GRADLE_USER_HOME="$XDG_CACHE_HOME/gradle"


export AWS_PROFILE=masl
export AWS_DEFAULT_REGION=eu-west-1

dpg-kubectl() {
    aws eks update-kubeconfig --name "dpg-eks-cluster-${1}"
}

airflow-bash() {
    local pod=`kubectl get pods -n airflow -l component=web -ojsonpath='{.items[0].metadata.name}'`
    kubectl exec -it -n airflow ${pod} bash
}


export NPM_CONFIG_PREFIX=${HOME}/.node_module
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/config




