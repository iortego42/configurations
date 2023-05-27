set termguicolors
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

function clear-ws(){
  echo "" >  /Users/nachh/.local/workspace.txt
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
alias ls='ls -G'
alias ll='lsd -lhF --group-dirs=first'
alias la='lsd -laF --group-dirs=first'
alias l='lsd -F --group-dirs=first'




function putFG(){
  foreground=$1
  f_seq="\[\033[38;5;${foreground}m\]"
  echo -n "${f_seq}"
}
function putBG(){
  background=$1
  b_seq="\[\033[38;5;${background}m\]"
  echo -n "${b_seq}"
}

R="\[\033[0m\]"
function parse_git_branch() {
  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    local status=$(git status --porcelain)
    local untracked=$(git ls-files --others --exclude-standard)
    local changed=$(git diff --name-only)
    local untracked_count=$(echo -n "$untracked" | wc -l | tr -d ' ')
    local changed_count=$(echo -n "$changed" | wc -l | tr -d ' ')
    local branch_info=""
        
    if [ -n "$status" ] || [ -n "$untracked" ]; then
      # Branch has uncommitted changes or untracked files
      branch_info+="$(putFG 221)$branch"  # Display branch name in red with asterisk
      if [ "$untracked_count" -gt 0 ]; then
        branch_info+=" $(putFG 39)?$untracked_count"  # Display untracked count with asterisk character
      fi
    else
      # Branch has no uncommitted changes or untracked files
      branch_info+="$(putFG 28)$branch"  # Display branch name in green
    fi
    if [ "$changed_count" -gt 0 ]; then
      branch_info+=" $(putFG 178)"$'\u2699'"$changed_count"  # Display changed count with gear character
    fi
    echo -n "$branch_info$R"
  fi
}

function workspace()
{
  local WSinfo=""
  if [ -d "$1" ]; then
    WSinfo+="$(putFG $WSIC)$R$(echo -n $1 | awk -F'/' '{print $NF}')"
  fi
  echo -n "$WSinfo"
}

function stripColors(){
  local str=""
  str="$(echo -n "$1" | sed -E 's/\\\[\\033\[[0-9;]*m\\\]//g')"
  echo -n "$str"
}

function prompt() {
  local status=$?
  promptFG=124
  # Right Delimitor
  RD='⦗'
  # Left Delimitor
  LD='⦘'
  # Other Right Delimitor
  ORD='┨'
  # Other Left Delimitor 
  OLD='┠'
  if [ "$USER" == "root" ]; then
    iconFG=140
    icon=$'\uf06e'
  else
    iconFG=220
    icon=$''
  fi
  #Github Prompt
  GS="$(git status 2>/dev/null | grep 'On branch')"
  GP=""
  GP_l=""
  if [ -n "$GS" ]; then
    #Github Icon
    GI=""
    INFO=$(parse_git_branch)
    #Untracked files
    # Github Color
    GC=77
    GP="⦗ $(putFG 27)$GI$(putFG $promptFG) ⦘-┨${INFO}$(putFG $promptFG)┠"
    GP_l="$(echo -n $GP | sed -E 's/\\\[\\033\[[0-9;]*m\\\]//g')"
  fi
  # User Prompt
  UP="$(putFG $promptFG)⦗ $(putFG $iconFG)$icon$(putFG $promptFG) ⦘"
  UP_l="⦗ $icon ⦘"
  # Line 1
  L1="$(putFG $promptFG)"$'\u250C'
  # Directory propmt
  if [ -n "$(echo -n $PWD | grep "$HOME")" ]; then
    if [ "$PWD" == "$HOME" ]; then
      DIR="󰀶"
    else
      DIR=$(echo -n $PWD | sed -E "s#$HOME#󰀶 #")
    fi
  else
    DIR=$PWD
  fi
  DC=7
  DP="⦗ $(putFG $DC)$DIR$R$(putFG $promptFG) ⦘"
  DP_l="$(echo -n "$DP" | sed -E 's/\\\[\\033\[[0-9;]*m\\\]//g')"
  
  # Workspace Icon
  WSicon=""
  WSIC=69
  # Workspace Prompt
  WP=""
  export WS="$(cat /users/nachh/.local/workspace.txt)"
  if [ -d "$WS" ]; then
    # Workspace Prompt
    WP="$RD $(putFG $WSIC)${WSicon} $(putFG 7)$(workspace $WS)$(putFG $promptFG) $LD"
  fi
  WP_l="$(echo -n "$WP" | sed -E 's/\\\[\\033\[[0-9;]*m\\\]//g')"
  cols=$(tput cols)
  chars=$(( cols - ${#DP_l} - ${#UP_l} - ${#GP_l} - ${#WP_l}))
  line=""
  for ((i = 1; i < chars; i++)); do
    line+="─"
  done
  if [ $status -eq 0 ]; then
    # Error Color
    ECFG=$promptFG
    # Error Prompt
    EP=""
    # PS1="$L1$line$UP\n"$'\u2514\u2500'" $R"
  else
    # Error Color
    ECFG=196
    # Error Prompt
    EP="❨$(putFG $ECFG)󰃤$R $status $(putFG $promptFG)❩"
    # PS1="$L1$line$UP\n"$'\u2514\u2500'"❨$(putFG 1)󰃤$R $status $(putFG $promptFG)❩$(putFG 1)$R "
  fi
  # Input Char
  IC="$(putFG $ECFG)$R "
  # Line Union
  LU=$'\u2514\u2500'
  # Prompt String 1
  PS1="$L1$DP$GP$line$WP$UP\n$LU$EP$IC"
}

PROMPT_COMMAND=prompt
