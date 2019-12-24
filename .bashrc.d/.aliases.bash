
# Color aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ls aliases
alias ll='ls -alF'

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

alias e="emacs -nw"
alias pip="pip3"
alias python="python3"

# macOs like pbcopy and pbpaste
alias pbcopy="xsel --clipboard --input"
alias pbpaste="xsel --clipboard --output"

# Network utilities
alias speedtest='echo "scale=2; `curl  --progress-bar -w "%{speed_download}" http://speedtest.wdc01.softlayer.com/downloads/test10.zip -o /dev/null` / 131072" | bc | xargs -I {} echo {} mbps'
alias myip="ip address | grep inet.*wlan0 | cut -d' ' -f6 | sed \"s/\/24//g\""

alias config='git --git-dir=/home/mlavaert/.dotfiles/ --work-tree=/home/mlavaert'
