# Allow global override to install packages via pip
function gpip() {
    PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

function path() {
    echo $PATH | tr ':' '\n'
}

function aws-credentials-for-docker() {
    echo "-e AWS_ACCESS_KEY_ID=`aws configure get aws_access_key_id` " \
         "-e AWS_SECRET_ACCESS_KEY=`aws configure get aws_secret_access_key` " \
         "-e AWS_SESSION_TOKEN=`aws configure get aws_session_token` "
}

function connect-vpn() {
    sudo openconnect -u mathias.lavaert@persgroep.net --juniper https://homeworker.persgroep.net
}

function fix-mouse {
    sudo modprobe -r psmouse && sudo modprobe psmouse
}
