# dotfiles
alias config='git --git-dir=/home/mlavaert/.dotfiles/ --work-tree=/home/mlavaert'
compdef config=git

# radio
alias willy="mpv https://playerservices.streamtheworld.com/api/livestream-redirect/WILLYAAC.AAC"

alias vim=nvim

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'
alias ll='ls -laF --color'
alias ls='ls --color'

alias q=exit
alias clr=clear
alias sudo='sudo '
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias wget='wget -c'

# aliases for tools
alias mk=make
alias tf=terraform
alias k=kubectl

alias y='xclip -selection clipboard -in'
alias p='xclip -selection clipboard -out'
