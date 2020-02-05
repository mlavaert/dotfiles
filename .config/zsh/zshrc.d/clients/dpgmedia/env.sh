#!/usr/bin/env zsh

export AWS_PROFILE=masl
export AWS_DEFAULT_REGION=eu-west-1

dpg-kubectl() {
    aws eks update-kubeconfig --name "dpg-eks-cluster-${1}"
}

airflow-bash() {
    local pod=`kubectl get pods -n airflow -l component=web -ojsonpath='{.items[0].metadata.name}'`
    kubectl exec -it -n airflow ${pod} bash
}
