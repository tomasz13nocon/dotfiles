export PATH=$PATH:~/.gem/ruby/2.3.0/bin:~/.local/bin

export TERM=xterm-256color

# Scroll 3 lines when using b/f or z/w instead of whole screen in less
export LESS='-R -z3'
export PAGER='less'
export EDITOR='vim'
export wfdeps='/opt/wildfly/standalone/deployments'
export LS_COLORS=$(ls_colors_generator)
run_ls() {
	ls-i --color=auto -w $(tput cols) "$@"
}
run_dir() {
	dir-i --color=auto -w $(tput cols) "$@"
}
run_vdir() {
	vdir-i --color=auto -w $(tput cols) "$@"
}
alias ls="run_ls"
alias dir="run_dir"
alias vdir="run_vdir"
alias ls='ls -l --color=auto --group-directories-first'
alias lsh='ls --block-size=h'
alias lsa='ls -A'
cl() {
	cd $1 && ls
}
alias diff='diff --color'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'
alias ..='cd ..'
alias py='python'
alias pym='python -m'
alias py2='python2'
alias rnet='systemctl restart NetworkManager'
#alias feh='feh -x --auto-zoom'
alias feh='feh --scale-down'
alias grep='grep --color=auto -P'
alias rgrep='grep -rIn'
alias rgrep2='rgrep --exclude-dir=vendors --exclude-dir=plugins --exclude-dir=WEB-INF --exclude-dir=css'
alias info='info --vi-keys'
alias yt2mp3='youtube-dl -x --audio-format=mp3'
alias htop='htop -d 8'
alias mpvtty='mpv -vo=drm'
alias stow='stow -v'
alias clip='xclip -selection clipboard'
alias echopath='echo $PATH | tr ":" "\n"'
alias clearswap='sudo swapoff -a && sudo swapon -a'
#alias vim='nvim'
alias bim='vim'
alias netdown='ip link set enp2s0 down'
alias netup='ip link set enp2s0 up'
alias netrestart='netdown && netup'
alias ds='df -h |grep /dev/sda\|Avail'

alias gs='git status'
alias gc='git commit'
alias gca='git commit -a'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gd='git diff'
alias ga='git add'
alias gch='git checkout'
alias gl='git log'
alias glo='git log --oneline'
alias gch='git checkout'
alias gb='git branch'

# disable Ctrl-S stopping terminal output
stty -ixon

# case insensitive glob
shopt -s nocaseglob

reset=$(tput sgr0)
bold=$(tput bold)
blue="\033[38;5;153m"
green="\033[38;5;149m"
purple="\033[38;5;140m"
export PS1="\[$bold\]\[$blue\]\u@\h\[$reset\] \[$purple\][\W]\[$reset\] \[$green\]$\[$reset\] "

