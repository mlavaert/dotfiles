# Setup PATH
source ~/.bashrc.d/.environment.bash
source ~/.bashrc.d/.path.bash

# Setup Z - jump around
source ~/.bashrc.d/.z.bash

# Setup pyenv
if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init - )"
	eval "$(pyenv virtualenv-init - )"
fi
