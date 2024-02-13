# General settings
# ================
export EDITOR="nvim"
export VISUAL=$EDITOR
export TERMINAL="foot"
export PAGER="less"
export MANPAGER=$PAGER
export BROWSER=/usr/bin/xdg-open

# Conveyor
export CONVEYOR_CONTAINER_MANAGER=podman

# XDG Specification
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_BIN_HOME="$HOME/.local/bin"

# Create XDG Directories if they do not exist
for dir in "$XDG_CACHE_HOME" "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_BIN_HOME"; do
	[ -d "$dir" ] || mkdir -p "$dir"
done

# Adapt existing tools to the specification
export PYENV_ROOT=$XDG_DATA_HOME/pyenv
export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$XDG_CACHE_HOME/pip
export IPYTHONDIR=$XDG_CONFIG_HOME/jupyter
export JUPYTER_CONFIG_DIR=$XDG_CONFIG_HOME/jupyter
export LESSKEY=$XDG_CONFIG_HOME/less/lesskey
export LESSHISTFILE=$XDG_CACHE_HOME/less/history
export Z_DATA=$XDG_CACHE_HOME/z

# Include my scripts in the PATH
if [[ -d "$HOME/.local/bin" ]]; then
	export PATH=$PATH:"$HOME"/.local/bin
fi

if [[ -d "$HOME/bin" ]]; then
	export PATH=$PATH:"$HOME"/bin
fi

if [[ -d "$HOME/.cargo/bin" ]]; then
	export PATH=$PATH:"$HOME"/.cargo/bin
fi

if [[ -d "$HOME/.local/share/pyenv/bin" ]]; then
	export PATH=$PATH:"$HOME"/.local/share/pyenv/bin
fi

# If not running interactively, don't do anything.  This too is taken
# from Debian 9's bashrc.
case $- in
*i*) ;;
*) return ;;
esac

show_virtual_env() {
	if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
		echo "[]"
	fi
}

show_aws_profile() {
	if [[ -n "$AWS_PROFILE" ]]; then
		echo "[☁️ $AWS_PROFILE]"
	fi
}

export -f show_virtual_env

# Simple prompt
if [ "$SSH_CONNECTION" != "" ]; then
	export PS1="\u@\h: \w \$ "
else
	source "$HOME/.local/share/git/git-prompt.sh"
	export PS1='\[\e[0;2m\]$(show_virtual_env)$(show_aws_profile) \w$(__git_ps1) \[\e[0;35m\]λ\[\e[0m\] '
fi
export PS2="> "

# The following is taken from the .bashrc shipped with Debian 9.  Enable
# programmable completion features (you don't need to enable this, if
# it's already enabled in /etc/bash.bashrc and /etc/profile sources
# /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# Enable tab completion when starting a command with 'sudo'
[ "$PS1" ] && complete -cf sudo

# Append to the history file, don't overwrite it.
shopt -s histappend

# Save multi-line commands in history as sinle line
shopt -s cmdhist

# For setting history length see HISTSIZE and HISTFILESIZE in `man bash`.
HISTFILE=${XDG_CACHE_HOME}/bash_history

# Don't put duplicate lines or lines starting with space in the history.
# See `man bash` for more options.
HISTCONTROL=ignoreboth
HISTSIZE=10000
PROMPT_COMMAND='history -a'

# Check the window size after each command and, if necessary, update the
# values of LINES and COLUMNS.
shopt -s checkwinsize

# Enable Vi-mode
set -o vi

# Options
shopt -s autocd  # Auto change to named directories
shopt -s cdspell # Auto-correct cd misspellings

#### Common tasks and utilities ####

# PRO TIP to ignore aliases, start them with a backslash \.  The
# original command will be used.  This is useful when the original
# command and the alias have the same name.  Example is my `cp` which is
# aliased to `cp -iv`:
#
#   cp == cp -iv
#   \cp == cp

# cd into the previous working directory by omitting `cd`
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Safer default for cp, mv, rm.  These will print a verbose output of
# the operations.  If an existing file is affected, they will ask for
# confirmation.  This can make things a bit more cumbersome, but is a
# generally safer option.
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv'

alias diff='diff --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Make ls a bit easier to read.  Note that the -A is the same as -a but
# does not include implied paths (the current dir denoted by a dot and
# the previous dir denoted by two dots).  I would also like to use the
# -p option, which prepends a forward slash to directories, but it does
# not seem to work with symlinked directories. For more, see `man ls`.
alias ls='ls -pv --color=auto --group-directories-first'
alias lsa='ls -pvA --color=auto --group-directories-first'
alias ll='ls -lhpv --color=auto --group-directories-first'
alias lla='ls -lhpvA --color=auto --group-directories-first'

alias y='xclip -in -selection clipboard'
alias p='xclip -out -selection clipboard'

# Dotfile managment
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias vim=nvim
alias docker=podman
alias willy="mpv https://playerservices.streamtheworld.com/api/livestream-redirect/WILLYAAC.AAC"
alias tmux='tmux -2'

# Plugins and tools
source "${HOME}/.local/share/z/z.sh"
source /usr/share/fzf/shell/key-bindings.bash
eval "$(direnv hook bash)"

# Small utilities
backupthis() {
	cp -riv "$1" "${1}-$(date +%Y%m%d%H%M).backup"
}

kcluster() {
	local cluster=$(aws eks list-clusters --output text "$@" | awk '{print $2}' | fzf)
	aws eks update-kubeconfig --name "$cluster"
}

kssh() {
	local pod=$(kubectl get pods "$@" | awk '/Running/ {print $1}' | fzf)
	kubectl exec --stdin --tty "$@" "$pod" -- /bin/bash
}

complete -C /home/mlavaert/.terraform.versions/terraform_1.6.6 terraform
