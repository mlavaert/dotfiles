# Setup pyenv
eval "$(pyenv init - )"
eval "$(pyenv virtualenv-init - )"

# Setup sdkman
export SDKMAN_DIR="${HOME}/.sdkman"
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"
