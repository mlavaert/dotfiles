source ~/.bashrc.d/git-prompt.sh
export PS1='\[\033[0;32m\]\u\[\033[0;36m\] \w\[\033[0;32m\]$(__git_ps1)\n└─ ▶\[\033[0m\] '

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -alF'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias pbcopy="xsel --clipboard --input"
alias pbpaste="xsel --clipboard --output"

alias config='git --git-dir=/home/mlavaert/.dotfiles/ --work-tree=/home/mlavaert'

source ~/.bashrc.d/.functions.bash
source ~/.bashrc.d/.z.bash

source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
