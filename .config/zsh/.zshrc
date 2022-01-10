# plugins
[ -d "$ZGEN_DIR" ] || git clone https://github.com/tarjoilija/zgen "$ZGEN_DIR"
source "$ZGEN_SOURCE"

if ! zgen saved; then
  # zgen load agkozak/zsh-z
  zgen load zdharma/fast-syntax-highlighting
  zgen load zsh-users/zsh-history-substring-search
  zgen load junegunn/fzf shell
  zgen save
fi

# autoload
autoload -Uz compinit edit-command-line 
zmodload zsh/complist

typeset -gU path fpath
path=($XDG_BIN_HOME $HOME/.config/emacs/bin $path)
fpath=($XDG_BIN_HOME $fpath)

# completions
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "~/.cache/zsh/zcompcache"

if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# external sources
source $ZDOTDIR/config.zsh
source $ZDOTDIR/userconfig.zsh
