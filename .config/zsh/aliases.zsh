# dotfiles
alias config='git --git-dir=/home/mlavaert/.dotfiles/ --work-tree=/home/mlavaert'

alias vim=nvim

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'
alias ll='ls -laF --color'

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

autoload -U zmv

take() {
	mkdir "$1" && cd "$1"
}
compdef take=mkdir

r() {
	local time=$1
	shift
	sched "$time" "notify-send --urgency=critical 'Reminder' '$@'; ding"
}
compdef r=sched
