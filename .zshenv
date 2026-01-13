export EDITOR="nvim"
export TERMINAL="ghostty"
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
export LESSKEY=$XDG_CONFIG_HOME/less/lesskey
export LESSHISTFILE=$XDG_CACHE_HOME/less/history
export Z_DATA=$XDG_CACHE_HOME/z

# OpenCode
export OPENCODE_ENABLE_EXA=false

# UV
export UV_NATIVE_TLS=true

if [ -f "$HOME/.env.secrets.gpg" ]; then
    eval "$(gpg --quiet --decrypt "$HOME/.env.secrets.gpg" 2> /dev/null)"
fi
