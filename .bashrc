function set-target() {
  echo "$1" > /Users/nachh/.local/target.txt
  export TARGET="$(cat /Users/nachh/.local/target.txt)"
}

function clear-target() {
  echo "$1" > /Users/nachh/.local/target.txt
  export TARGET="$(cat /Users/nachh/.local/target.txt)"
}

function set-ws() {
  if [ -d "$1" ]; then
    export WS="$1";
  else
    export WS="$(pwd)"
  fi
  echo "$WS" >  /Users/nachh/.local/workspace.txt
}

function cdws() {
  export WS=$(cat /Users/nachh/.local/workspace.txt)
  if [ -z $WS ]; then 
    echo "ERROR: No hay ningun espacio de trabajo"
  else
    cd $WS
  fi
}

function hex-encode() {
  echo "$@" | xxd -p
}

function hex-decode() {
  echo "$@" | xxd -p -r
}
function showcolors() {
  for i in {0..255}; do 
    print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}
  done

}
function rot13() {
  echo "$@" | tr 'A-Za-z' 'N-ZA-Mn-za-m'
}

function mkws() {
  mkdir -p $1/{nmap,content,exploits,Imgs}
}

export TARGET="$(cat /Users/nachh/.local/target.txt)"
export WS="$(cat /users/nachh/.local/workspace.txt)"
#
# INCLUSION BINARIOS
#
# PYTHON TO PYTHON3
export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"
# JOHN tools
export PATH="/opt/homebrew/Cellar/john-jumbo/1.9.0_1/share/john:$PATH"
# OPENSSL PATH
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
# ERROR PATH DOCKER 
export PATH="$PATH:/usr/local/bin"
# HOMEBREW
eval "$(/opt/homebrew/bin/brew shellenv)"
# RBENV
export PATH="/Users/nachh/.rbenv/versions/3.2.1/bin:$PATH"
# BINARIOS PROPIOS
export PATH="$HOME/.config/bin:$PATH"
# FINDUTILS
export PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"
#VMWARE OVF TOOLS
export PATH="$PATH:/Applications/VMware OVF Tool"
# alias
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
#
#-------/ CUSTOM ALIASES /-------
#
alias bashcolors='for ((i=0; i<256; i++)); do printf "\e[48;5;%dm\e[38;5;15m%3d\e[0m " "$i" "$i"; if (( (i+1) % 16 == 0 )); then echo; fi; done'
alias ls='ls -F --color=auto'
alias ll='lsd -lhF --group-dirs=first'
alias la='lsd -laF --group-dirs=first'
alias l='lsd -F --group-dirs=first'

function prompt() {
  local status=$?
  cols=$(tput cols)
  chars=$(( cols - ${#L1_l} - ${#UP_l}))
  line=""
  for ((i = 1; i < chars; i++)); do
    line+="─"
  done
  if [ "$USER" == "root" ]; then
    UP="\033[38;5;33m⦗\033[38;5;33m"$'\uf06e'" \033[38;5;33m⦘"
    UP_l="⦗"$'\uf06e'" ⦘"
  else
    UP="\033[38;5;33m⦗\033[38;5;117m󰀶 \033[38;5;33m⦘"
    UP_l="⦗󰀶 ⦘"
  fi
  L1="\033[38;5;33m"$'\u250C'"⦗\033[0m$PWD\033[38;5;33m⦘"
  L1_l="[$PWD]"
  cols=$(tput cols)
  chars=$(( cols - ${#L1_l} - ${#UP_l}))
  line=""
  for ((i = 1; i < chars; i++)); do
    line+="─"
  done
  if [ $status -eq 0 ]; then
    PS1="$L1$line$UP\n"$'\u2514\u2500'" \033[0m"
  else
    PS1="$L1$line$UP\n"$'\u2514\u2500'"❨\033[31m󰃤\033[0m $status \033[38;5;33m❩\033[31m \033[0m"
  fi
}
PROMPT_COMMAND=prompt
