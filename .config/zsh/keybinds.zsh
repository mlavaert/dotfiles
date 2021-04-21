autoload -U is-at-least

## vi-mode ###############
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins ' ' magic-space
# bindkey -M viins '^I' expand-or-complete-prefix

# Open current prompt in external editor
autoload -Uz edit-command-line; zle -N edit-command-line
bindkey '^ ' edit-command-line
bindkey -M viins '^n' history-substring-search-down
bindkey -M viins '^p' history-substring-search-up
bindkey -M viins '^s' history-incremental-pattern-search-backward
bindkey -M viins '^u' backward-kill-line
bindkey -M viins '^w' backward-kill-word
bindkey -M viins '^b' backward-word
bindkey -M viins '^f' forward-word
bindkey -M viins '^g' push-line-or-edit
bindkey -M viins '^a' beginning-of-line
bindkey -M viins '^e' end-of-line
bindkey -M viins '^d' push-line-or-edit
bindkey -M vicmd '^k' kill-line
bindkey -M vicmd 'H'  run-help
# Shift + Tab
bindkey -M viins '^[[Z' reverse-menu-complete
# bind UP and DOWN arrow keys
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# C-z to toggle current process (background/foreground)
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

# Fix the DEL key
bindkey -M vicmd "^[[3~" delete-char
bindkey "^[[3~" delete-char

# Fix vimmish ESC
bindkey -sM vicmd '^[' '^G'
bindkey -rM viins '^X'
bindkey -M viins '^X,' _history-complete-newer \
  '^X/' _history-complete-older \
  '^X`' _bash_complete-word
