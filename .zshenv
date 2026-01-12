export EDITOR="nvim"
export TERMINAL="foot"
export BROWSER="google-chrome"
export GPG_TTY=$(tty)

export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export ZGEN_AUTOLOAD_COMPINIT=0
export ZVM_INIT_MODE=sourcing

# Adapt existing tools to the specification
export PYENV_ROOT=$XDG_DATA_HOME/pyenv
export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$XDG_CACHE_HOME/pip
export IPYTHONDIR=$XDG_CONFIG_HOME/jupyter
export JUPYTER_CONFIG_DIR=$XDG_CONFIG_HOME/jupyter
export LESSKEY=$XDG_CONFIG_HOME/less/lesskey
export LESSHISTFILE=$XDG_CACHE_HOME/less/history
export Z_DATA=$XDG_CACHE_HOME/z


# ZScaler
export ZSCALER_ROOT_CERT=$HOME/.zcli/zscaler_root.pem;
# export AWS_CA_BUNDLE=/opt/homebrew/etc/ca-certificates/cert.pem;
# export NODE_EXTRA_CA_CERTS=$HOME/.zcli/zscaler_root.pem;
## Python
export UV_NATIVE_TLS=true
# export REQUESTS_CA_BUNDLE=$HOME/.zcli/zscaler_root.pem;

# SOPS
export SOPS_KMS_ARN="arn:aws:kms:eu-west-1:767397876121:alias/data-platform-build-sops-key"

if [ -f "$HOME/.env.secrets.gpg" ]; then
    eval "$(gpg --quiet --decrypt "$HOME/.env.secrets.gpg" 2> /dev/null)"
fi
