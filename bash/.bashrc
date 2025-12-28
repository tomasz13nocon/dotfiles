export PATH=$PATH:~/.local/bin:~/bin:~/.local/share/cargo/bin:~/.local/share/gem/ruby/3.0.0/bin:~/.local/share/nvim/mason/bin:~/.local/share/go/bin

export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache

# Cleanup $HOME
export HISTFILE="$XDG_STATE_HOME"/bash/history
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export ELECTRUMDIR="$XDG_DATA_HOME"/electrum
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
export WINEPREFIX="$XDG_DATA_HOME"/wine
export W3M_DIR="$XDG_DATA_HOME"/w3m
export SQLITE_HISTORY="$XDG_CACHE_HOME"/sqlite_history
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
export REDISCLI_HISTFILE="$XDG_DATA_HOME"/redis/rediscli_history
export PSQL_HISTORY="$XDG_DATA_HOME/psql_history"
export OMNISHARPHOME="$XDG_CONFIG_HOME"/omnisharp
export NVM_DIR="$XDG_DATA_HOME"/nvm # also defined below by nvm's code
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export LESSHISTFILE="$XDG_STATE_HOME"/less/history
export ANDROID_USER_HOME="$XDG_DATA_HOME"/android
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export XCOMPOSEFILE="$XDG_CONFIG_HOME"/X11/xcompose
export XCOMPOSECACHE="$XDG_CACHE_HOME"/X11/xcompose

alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
alias adb='HOME="$XDG_DATA_HOME"/android adb'
alias monerod='monerod --data-dir "$XDG_DATA_HOME"/bitmonero'

#export TERM=xterm-256color

# Scroll 3 lines when using b/f or z/w instead of whole screen in less
export LESS='-R -z3'
export PAGER='less'
export EDITOR='nvim'
export MANPAGER='less'
export FZF_DEFAULT_COMMAND='rg --hidden --files -g !builds -g !node_modules -g !package-lock.json'


#. /usr/share/LS_COLORS/dircolors.sh
export LS_COLORS="$(vivid generate ayu)"

source ~/.aliases

# disable Ctrl-S stopping terminal output
stty -ixon

# disable Ctrl-Z
# stty susp undef

# case insensitive glob
shopt -s nocaseglob

# SHELL HISTORY
# Avoid duplicates
#HISTCONTROL=ignoredups:erasedups
# Leading space disables history
HISTCONTROL=ignorespace:ignoredups
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
if command -v fre &> /dev/null; then
  PROMPT_COMMAND="${PROMPT_COMMAND:+$(echo "${PROMPT_COMMAND}" | awk '{gsub(/; *$/,"")}2') ; }"'fre --add "$(pwd)"'
fi

pacs() {
  packages=$(pacman -Ssq | fzf -m --preview="pacman -Si {}" --preview-window=:hidden --bind=space:toggle-preview)
  [ -z "$packages" ] || sudo pacman -S $packages
}

cdf() {
  cd "$(cat <(fre --sorted) <(fd -L -t d) | fzf --no-sort --preview="echo {} && lsd -l --icon=always --color=always --blocks=name -L {}" --bind="space:toggle-preview")"
}
open_with_fzf() {
    #fd -t f -H -I | fzf -m --preview="xdg-mime query default {}" | xargs -ro -d "\n" xdg-open 2>&-
  fd -L | fzf --preview="bat --decorations always --color always 2>/dev/null {} || ls {}" | xargs -rod "\n" rifle
}
bind '"\C-o":"open_with_fzf\n"'
bind '"\C-p":"cdf\n"'
bind '"\x1b[105;5u":"PREV_DIR=$(pwd) && cd ~/dotfiles/nvim && vim && cd $PREV_DIR\n"'

#source /usr/share/bash-complete-alias/complete_alias
#complete -F _complete_alias wifi




######## PS1 ########

##### UTILS #####
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

####### COLORS #######
# colors=("#809bce" "#95b8d1" "#b8e0d2" "#d6eadf" "#eac4d5")
# colors=("#A69D93" "#8C8C83" "#8B8484")
colors=("#3D271E" "#653F30" "#8E5A45")
    # background:                  #2D1B14;
    # background-alt:              #462D23;
    # foreground:                  #FFFFFF;
    # selected:                    #E25F3E;
    # active:                      #7B6C5B;
    # urgent:                      #934A1C;
# coltext="111111"
coltext="#E4BFB4"

##### SEGMENTS #####
git_branch() {
  str=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  max_len=30

  # printf '%.*s' $max_len $str
  if (( "${#str}" > "$((max_len))" )); then
    printf "(%s%s)" "${str:0:$max_len}" $'\u2026'
  elif (( "${#str}" > 0 )); then
    printf "(%s)" "$str"
  fi
}
# segments=("\d" "\t" "\u@\h" "[\W]" "\$(git_branch)")
segments=("\u@\h" "[\W]" "\$(git_branch)")

# Separators
#sepleft=$'\uE0C7'
# sepleft=$'\uE0b6'
sep=$'\uE0C6'
# sep=$'\uE0b4'

##### PUTTING IT TOGETHER #####
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
    if [ -z "${segments[$i]}" ]; then
      continue
    fi
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


export NVM_DIR="$HOME/.local/share/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Must be after shell extensions that manipulate the prompt.
eval "$(direnv hook bash)"

# opencode
export PATH=/home/user/.opencode/bin:$PATH
