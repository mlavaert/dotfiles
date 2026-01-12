# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# shellcheck disable=SC2296
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ------------------------------------------------------------------------------
# PATH Configuration (MUST be early!)
# ------------------------------------------------------------------------------

# Detect OS early for PATH adjustments
OS="$(uname -s)"

# macOS Specific: Ensure system paths are present before modifying anything
# This fixes issues where /bin or /usr/bin might be missing or shadowed
if [[ "$OS" == "Darwin" ]]; then
    # Ensure basic system paths are included if they appear missing
    if [[ ":$PATH:" != *":/bin:"* ]]; then
        export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
    fi
fi

# Initialize Homebrew if available
if [[ -x "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Include custom binary paths
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

if [[ -d "$HOME/.opencode/bin" ]]; then
    export PATH="$PATH:$HOME/.opencode/bin"
fi

# Load NVM if present
if [[ -d "$HOME/.config/nvim" ]]; then
  export NVM_DIR="$HOME/.config/nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# Deduplicate PATH to keep it clean
typeset -U PATH path

# ------------------------------------------------------------------------------
# External Tools (require PATH to be set)
# ------------------------------------------------------------------------------

# Automatically start Zellij if installed
if command -v zellij >/dev/null 2>&1; then
    eval "$(zellij setup --generate-auto-start zsh)"
fi

# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname "$ZINIT_HOME")"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Zinit Plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light jeffreytse/zsh-vi-mode
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

# Snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::terraform
zinit snippet OMZP::command-not-found

# Completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# P10k Config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ------------------------------------------------------------------------------
# Aliases
# ------------------------------------------------------------------------------

# Detect OS (Already detected at top, but keeping variable for other scripts)
# OS="$(uname -s)"

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Safer file operations
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

# Dotfile management
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Tool aliases
alias vim=nvim
alias willy="mpv https://playerservices.streamtheworld.com/api/livestream-redirect/WILLYAAC.AAC"
alias tmux='tmux -2'
alias tf='terraform'
alias dbtf="$HOME/.local/bin/dbt"

# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------

function get-aws-profiles() {
        rg -o '\[profile (.*administrator-cf)' -r '$1' "$HOME/.aws/config"
}

function retry() {
	until "$@"
	do
		echo "Operation failed, retrying..."
	done
}

function patch-python-venv() {
  echo "-> Patching virtualenv with ZScaler Certificate"
  openssl x509 -in "${ZSCALER_ROOT_CERT}" -text >> "$VIRTUAL_ENV"/lib/python*/site-packages/certifi/cacert.pem
}

function edit-secrets() {
    local SECRETS_FILE="$HOME/.env.secrets.gpg"
    local TEMP_FILE="$HOME/.env.secrets.tmp"
    local EDITOR_CMD="${EDITOR:-vim}"

    # Ensure required commands are available
    if ! command -v gpg >/dev/null 2>&1; then
        echo "Error: gpg is not installed or not in PATH."
        return 1
    fi

    # Decrypt to temp file
    if [ -f "$SECRETS_FILE" ]; then
        if ! command gpg --quiet --decrypt "$SECRETS_FILE" > "$TEMP_FILE"; then
            echo "Error: Failed to decrypt secrets."
            return 1
        fi
    else
        touch "$TEMP_FILE"
    fi
    
    # Edit temp file
    $EDITOR_CMD "$TEMP_FILE"
    
    # Encrypt back if changes were made
    if [ -f "$TEMP_FILE" ]; then
        if command gpg --batch --yes --trust-model always --encrypt --recipient mathias@pilcrow.be --output "$SECRETS_FILE" "$TEMP_FILE"; then
            command rm "$TEMP_FILE"
            echo "Secrets updated and re-encrypted."
        else
            echo "Error: Failed to encrypt secrets. Temporary file kept at $TEMP_FILE"
            return 1
        fi
    fi
}

alias aws-profile='export AWS_PROFILE=$(get-aws-profiles | fzf)'
alias aws-account-id='aws sts get-caller-identity --query "Account" --output text'

# ------------------------------------------------------------------------------
# History & Options
# ------------------------------------------------------------------------------

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

# ------------------------------------------------------------------------------
# Integrations (FZF, Zoxide, Direnv)
# ------------------------------------------------------------------------------

# FZF Bindings
FZF_BINDINGS=""
for path in \
  "/usr/share/fzf/shell/key-bindings.zsh" \
  "/usr/local/opt/fzf/shell/key-bindings.zsh" \
  "/opt/homebrew/opt/fzf/shell/key-bindings.zsh" \
  "$HOME/.fzf/shell/key-bindings.zsh" \
  "$HOME/.nix-profile/share/fzf/key-bindings.zsh"; do
  if [[ -f "$path" ]]; then
      FZF_BINDINGS="$path"
      break
  fi
done

if [[ -n "$FZF_BINDINGS" ]]; then
    # shellcheck disable=SC1090
    source "$FZF_BINDINGS"
fi

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

if command -v direnv >/dev/null 2>&1; then
    eval "$(direnv hook zsh)"
fi

autoload -U +X bashcompinit && bashcompinit
fpath+=~/.zfunc; autoload -Uz compinit; compinit
zstyle ':completion:*' menu select
