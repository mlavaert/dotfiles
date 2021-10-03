#/usr/bin/env zsh

# Treat these characters as part of a word.
WORDCHARS='_-*?[]~&.;!#$%^(){}<>'

unsetopt BRACE_CCL        # Allow brace character class list expansion.
setopt COMBINING_CHARS    # Combine zero-length punc chars (accents) with base char
setopt RC_QUOTES          # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'
setopt HASH_LIST_ALL
unsetopt CORRECT_ALL
unsetopt NOMATCH
unsetopt MAIL_WARNING     # Don't print a warning message if a mail file has been accessed.
unsetopt BEEP             # Hush now, quiet now.
setopt IGNOREEOF

## Jobs
setopt LONG_LIST_JOBS     # List jobs in the long format by default.
setopt AUTO_RESUME        # Attempt to resume existing job before creating a new process.
setopt NOTIFY             # Report status of background jobs immediately.
unsetopt BG_NICE          # Don't run all background jobs at a lower priority.
unsetopt HUP              # Don't kill jobs on shell exit.
unsetopt CHECK_JOBS       # Don't report on jobs when shell exit.

## History
HISTFILE="$XDG_CACHE_HOME/zsh/history"
HISTSIZE=4000                    # Max events to store in internal history.
SAVEHIST=4000                    # Max events to store in history file.

setopt BANG_HIST                 # Don't treat '!' specially during expansion.
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

## Directories
DIRSTACKSIZE=9
setopt AUTO_CD              # Auto changes to a directory without typing cd.
setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME        # Push to home directory when no argument is given.
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt MULTIOS              # Write to multiple descriptors.
setopt EXTENDED_GLOB        # Use extended globbing syntax.
unsetopt GLOB_DOTS
unsetopt AUTO_NAME_DIRS     # Don't add variable-stored paths to ~ list


# ########
# Keybinds
# ########
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


# ######
# Prompt
# ######
# Loosely based off Pure <https://github.com/sindresorhus/pure>

_strlen() { echo ${#${(S%%)1//$~%([BSUbfksu]|([FB]|){*})/}}; }

# fastest possible way to check if repo is dirty
prompt_git_dirty() {
  command -v git >/dev/null || return

  # check if we're in a git repo
  [[ "$(command git rev-parse --is-inside-work-tree 2>/dev/null)" == "true" ]] || return
  # check if it's dirty
  command test -n "$(git status --porcelain --ignore-submodules -unormal)" || return

  local r=$(command git rev-list --right-only --count HEAD...@'{u}' 2>/dev/null)
  local l=$(command git rev-list --left-only --count HEAD...@'{u}' 2>/dev/null)

  (( ${r:-0} > 0 )) && echo -n " %F{red}${r}-"
  (( ${l:-0} > 0 )) && echo -n " %F{green}${l}+"
  echo -n '%f'
}

## Hooks ###############################
prompt_hook_precmd() {
  vcs_info # get git info
  # Newline before prompt, except on init
  [[ -n $PROMPT_DONE ]] && print ""; PROMPT_DONE=1
}

## Initialization ######################
prompt_init() {
  # prevent percentage showing up
  # if output doesn't end with a newline
  export PROMPT_EOL_MARK=

  # prompt_opts=(cr subst percent)
  setopt promptsubst
  autoload -Uz add-zsh-hook
  autoload -Uz vcs_info

  add-zsh-hook precmd prompt_hook_precmd
  # Updates cursor shape and prompt symbol based on vim mode
  zle-keymap-select() {
    case $KEYMAP in
      vicmd)      PROMPT_SYMBOL="%F{green}« " ;;
      main|viins) PROMPT_SYMBOL="%(?.%F{magenta}.%F{yellow})λ " ;;
    esac
    zle reset-prompt
    zle -R
  }
  zle -N zle-keymap-select
  zle -A zle-keymap-select zle-line-init

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' use-simple true
  zstyle ':vcs_info:*' max-exports 2
  zstyle ':vcs_info:git*' formats ' %b'
  zstyle ':vcs_info:git*' actionformats ' %b (%a)'

  # show username@host if logged in through SSH
  if [[ -n $SSH_CONNECTION ]]; then
    prompt_username='%m '
    if [[ $(whoami) != mlavaert ]]; then
      prompt_username="%n.$prompt_username"
    fi
  fi

  RPROMPT='%F{blue}%~%F{magenta}${vcs_info_msg_0_}$(prompt_git_dirty)%f'
  PROMPT='%F{magenta}${prompt_username}%f${PROMPT_SYMBOL:-$ }%f'
}

prompt_init "$@"
