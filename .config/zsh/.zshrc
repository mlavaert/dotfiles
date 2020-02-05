# paths
typeset -gU cdpath fpath mailpath path
path=( $XDG_BIN_HOME $HOME/.bin $HOME/.node_modules/bin  $path )

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_BIN_HOME="$HOME/.local/bin"

export ZSHRCD_HOME="$XDG_CONFIG_HOME/zsh/zshrc.d"

for dir in "$XDG_CACHE_HOME" "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_BIN_HOME";do 
    [[ -d $dir ]] || mkdir -p "$dir"
done

function _is_interactive {
  [[ $- == *i* || -n $EMACS ]];
}

function _is_running {
  for prc in "$@"; do 
    pgrep -x "$prc" > /dev/null || return 1
  done
}

function _is_callable {
  for cmd in "$@"; do
    command -v "$cmd" >/dev/null || return 1
  done
}

function _load_all {
  for file in "$ZSHRCD_HOME"/*/*/"$1"; do
    [[ -e $file ]] && source "$file"
  done
}

function _ssource {
  [[ -f "$1" ]] && source "$1"
}

function _load_repo {
  _ensure_repo "$1" "$2" && source "$2/$3" || >&2 echo "Failed to load $1"
}

function _ensure_repo {
  local target=$1
  local dest=$2
  if [[ ! -d $dest ]]; then
    if [[ $target =~ "^[^/]+/[^/]+$" ]]; then
      url=https://github.com/$target
    elif [[ $target =~ "^[^/]+$" ]]; then
      url=git@github.com:$USER/$target.git
    fi
    [[ -n ${dest%/*} ]] && mkdir -p ${dest%/*}
    git clone --recursive "$url" "$dest" || return 1
  fi
}

function _cache {
  local cache_dir="$XDG_CACHE_HOME/${SHELL##*/}"
  local cache="$cache_dir/$1"
  if [[ ! -f $cache || ! -s $cache ]]; then
    echo "Caching $1"
    mkdir -p $cache_dir
    "$@" >$cache
  fi
  source $cache
}

function _cache_clear {
  command rm -rfv $XDG_CACHE_HOME/${SHELL##*/}/*;
}

autoload -Uz compinit && compinit
zmodload -i zsh/complist

zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate #enable approximate matches for completion

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -alF'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias y="xsel --clipboard --input"
alias p="xsel --clipboard --output"
alias vim=nvim

alias ..="cd .."
alias ...="cd ../.."

alias config='git --git-dir=/home/mlavaert/.dotfiles/ --work-tree=/home/mlavaert'

eval "$(fasd --init auto)"

_ssource /usr/share/fzf/key-bindings.zsh
_ssource /usr/share/fzf/completion.zsh

_load_all env.zsh

source <(antibody init)
