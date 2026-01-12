# Automatically start TMUX 
# if [ -z "$TMUX" ]
# then
#     tmux attach -t TMUX || tmux new -s TMUX
# fi

# Detect OS
OS="$(uname -s)"

eval "$(zellij setup --generate-auto-start zsh)"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light jeffreytse/zsh-vi-mode
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::terraform
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

if [[ "$OS" == "Linux" ]]; then
    alias diff='diff --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    # Linux ls configuration
    alias ls='ls -pv --color=auto '
    alias lsa='ls -pvA --color=auto '
    alias ll='ls -lhpv --color=auto '
    alias lla='ls -lhpvA --color=auto '

    # Wayland clipboard
    if command -v wl-copy &> /dev/null; then
        alias y='wl-copy'
        alias p='wl-paste'
    elif command -v xclip &> /dev/null; then
        alias y='xclip -selection clipboard'
        alias p='xclip -selection clipboard -o'
    fi

elif [[ "$OS" == "Darwin" ]]; then
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    # macOS ls configuration (using BSD ls)
    export CLICOLOR=1
    alias ls='ls -p'
    alias lsa='ls -pA'
    alias ll='ls -lhp'
    alias lla='ls -lhpA'

    # macOS clipboard
    alias y='pbcopy'
    alias p='pbpaste'
fi

# Dotfile managment
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias vim=nvim
alias willy="mpv https://playerservices.streamtheworld.com/api/livestream-redirect/WILLYAAC.AAC"
alias tmux='tmux -2'
alias tf='terraform'

function get-aws-profiles() {
        rg -o '\[profile (.*administrator-cf)' -r '$1' "$HOME/.aws/config"
}

function retry() {
	until `$@`
	do
		echo "Operation failed, retrying..."
	done
}

function patch-python-venv() {
  echo "-> Patching virtualenv with ZScaler Certificate"
  openssl x509 -in ${ZSCALER_ROOT_CERT} -text >> $VIRTUAL_ENV/lib/python*/site-packages/certifi/cacert.pem
}

alias aws-profile='export AWS_PROFILE=$(get-aws-profiles | fzf)'
alias aws-account-id='aws sts get-caller-identity --query "Account" --output text'

# History configuration
HISTFILE="$XDG_CACHE_HOME/zhistory"
HISTSIZE=100000   # Max events to store in internal history.
SAVEHIST=100000   # Max events to store in history file.

setopt BANG_HIST                 # Don't treat '!' specially during expansion.
setopt EXTENDED_HISTORY          # Include start time in history records
setopt APPEND_HISTORY            # Appends history to history file on exit
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Remove old events if new event is a duplicate
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_REDUCE_BLANKS        # Minimize unnecessary whitespace
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing non-existent history.

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

if [[ -d "/opt/nvim/bin" ]]; then
	export PATH=$PATH:/opt/nvim/bin
fi

if [[ -d "${HOME}/.local/share/coursier/bin" ]]; then
	export PATH=$PATH:"$HOME"/.local/share/coursier/bin
fi

if [[ -d "$HOME/.config/nvim" ]]; then
  export NVM_DIR="$HOME/.config/nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# Integrations
# Attempt to find and source fzf key bindings
FZF_BINDINGS=""
if [[ -f "/usr/share/fzf/shell/key-bindings.zsh" ]]; then
    FZF_BINDINGS="/usr/share/fzf/shell/key-bindings.zsh"
elif [[ -f "/usr/local/opt/fzf/shell/key-bindings.zsh" ]]; then
    FZF_BINDINGS="/usr/local/opt/fzf/shell/key-bindings.zsh"
elif [[ -f "/opt/homebrew/opt/fzf/shell/key-bindings.zsh" ]]; then
    FZF_BINDINGS="/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
elif [[ -f "${HOME}/.fzf/shell/key-bindings.zsh" ]]; then
    FZF_BINDINGS="${HOME}/.fzf/shell/key-bindings.zsh"
fi

if [[ -n "$FZF_BINDINGS" ]]; then
    source "$FZF_BINDINGS"
fi

eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

autoload -U +X bashcompinit && bashcompinit
fpath+=~/.zfunc; autoload -Uz compinit; compinit
zstyle ':completion:*' menu select


# Added by dbt installer
export PATH="$PATH:$HOME/.local/bin"

# dbt aliases
alias dbtf="$HOME/.local/bin/dbt"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"
