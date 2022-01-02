export PATH=$PATH:~/.local/bin:~/bin

#export TERM=xterm-256color

# Scroll 3 lines when using b/f or z/w instead of whole screen in less
export LESS='-R -z3'
export PAGER='less'
export EDITOR='vim'

#. /usr/share/LS_COLORS/dircolors.sh
export LS_COLORS="$(vivid generate ayu)"

source .aliases

# disable Ctrl-S stopping terminal output
stty -ixon

# case insensitive glob
shopt -s nocaseglob

# SHELL HISTORY
# Avoid duplicates
#HISTCONTROL=ignoredups:erasedups
# Big history
export HISTSIZE=10000
export HISTFILESIZE=10000
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
# After each command, append to the history file and reread it
#PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

#make stderr red
#exec 9>&2
#exec 8> >(
    #while IFS='' read -r line || [ -n "$line" ]; do
       #echo -e "\033[31m${line}\033[0m"
    #done
#)
#function undirect(){ exec 2>&9; }
#function redirect(){ exec 2>&8; }
#trap "redirect;" DEBUG
#PROMPT_COMMAND='undirect;'

######## PS1 ########
# Old colors
blue="\033[38;5;153m"
green="\033[38;5;149m"
purple="\033[38;5;140m"

fg() {
	echo -n "\[\e[38;2;$1;$2;$3m\]"
}
bg() {
	echo -n "\[\e[48;2;$1;$2;$3m\]"
}
rgb() {
	local hex=$1
	if [[ $hex =~ ^#.* ]]; then
		hex=${hex:1}
	fi
	printf "%d %d %d" 0x${hex:0:2} 0x${hex:2:2} 0x${hex:4:2}
}
#reset=$(tput sgr0)
reset="\[\e[0m\]"
#bold=$(tput bold)
bold="\[\e[1m\]"

# Colors (hex)
colors=("809bce" "95b8d1" "b8e0d2" "d6eadf" "eac4d5")
#colors=("A69D93" "8C8C83" "8B8484")
coltext="111111"

# Text segments
segments=("\d" "\t" "\u@\h" "[\W]" "\!")

# Separators
#sepleft=$'\uE0C7'
#sep=$'\uE0C6'
#sepleft=$'\uE0b6'
sep=$'\uE0b4'
#sepsoft=$'\uE0B5'

makeps1() {
	coltext=$(fg $(rgb $coltext))
	colorsfg=()
	colorsbg=()
	for i in "${colors[@]}"; do
		colorsfg+=($(fg $(rgb $i)))
		colorsbg+=($(bg $(rgb $i)))
	done
	echo -n ${colorsbg[0]}

	if [ -n "$sepleft" ]; then
		echo -n ${colorsfg[0]}
		echo -n $sepleft
	fi

	echo -n ${colorsbg[0]}
	echo -n $coltext
	echo -n " ${segments[0]} "
	for ((i=1; i < ${#segments[@]}; i++)); do
		echo -n ${colorsbg[$i]}
		echo -n ${colorsfg[(($i - 1))]}
		echo -n $sep
		echo -n $coltext
		echo -n " ${segments[$i]} "
	done
	echo -n $reset
	echo -n ${colorsfg[(($i - 1))]}
	echo -n $sep
	echo -n "$reset "
}
export PS1=$(makeps1)
