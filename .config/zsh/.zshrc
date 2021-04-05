# autoload
autoload -U compinit \
  edit-command-line 
zmodload zsh/complist

# init
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "~/.cache/zsh/zcompcache"

compinit -u; _comp_options+=(globdots) # include hidden files
zle -N edit-command-line

typeset -gU path fpath mailpath cdpath
path=($XDG_BIN_HOME $HOME/.config/emacs/bin $path)
fpath=($XDG_BIN_HOME $fpath)

# set
HISTSIZE=8000
SAVEHIST=8000
HISTFILE=~/.cache/zsh/history

eval "$(direnv hook zsh)"
eval "$(starship init zsh)"

# setopts
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt APPEND_HISTORY            # Appends history to history file on exit
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing non-existent history.

## navigation
setopt AUTO_CD
setopt EXTENDED_GLOB
setopt COMPLETE_ALIASES
compdef _zshz ${ZSHZ_CMD:-${_Z_CMD:-z}}

# external sources
source $ZDOTDIR/zsh-z.plugin.zsh
source $ZDOTDIR/extra.zsh
source $ZDOTDIR/aliases.zsh
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

## vi mode
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins ' ' magic-space
bindkey '^ ' edit-command-line
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
