function putFG(){
  foreground=$1
  f_seq="%F{$foreground}"
  echo -n "$f_seq"
}
function putBG(){
  background=$1
  b_seq="\[\e[38;5;${background}m\]"
  echo -en "${b_seq}"
}

italic="\[\e[3m\]"
bold="%B"
R="%f%b"
function parse_git_branch() {
  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    local gitstatus=$(git status --porcelain)
    local untracked=$(git ls-files --others --exclude-standard)
    local changed=$(git diff --name-only)
    local untracked_count=$(echo -n "$untracked" | wc -l | tr -d ' ')
    local changed_count=$(echo -n "$changed" | wc -l | tr -d ' ')
    local branch_info=""
        
    if [ -n "$gitstatus" ] || [ -n "$untracked" ]; then
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




# Line character
L='─'
# Right Delimitor
RD=']'
# Left Delimitor
LD='['
# Right Parentesis Delimitor
RPD=')'
# Left Parentesis Delimitor
LPD='('
# Other Right Delimitor
OLD='┨'
# Other Left Delimitor 
ORD='┠'
promptFG=82


function workspace()
{
  local WSIC=$1
  local WSinfo=""
  if [ -d "$WS" ]; then
    WSinfo+="$(putFG $WSIC)$(echo -n $WS | awk -F'/' '{print $NF}')"
  fi
  echo -n "$WSinfo"
}

function strip() {
  local string="$1"
  string=$(echo "$string" | sed 's/%F{[0-9]*}//g')
  string=$(echo "$string" | sed 's/%[fbBF]//g')

  echo "$string"
}

function user() {
  local UP="$LD"
  local usernamecolor=255 
  if [[ "$USER" == "root" ]]; then
    usernamecolor=1
    UP+=$bold
  fi
  UP+="$(putFG $usernamecolor)$USER$R"
  if [ -d "$WS" ]; then
    local wscolor=39
    UP+="$bold@$R$(workspace $wscolor)"
  fi
  UP+="$(putFG $promptFG)$RD"
  echo -n "$UP"
}

function precmd() {
  local cmd_status=$?
  if [[ "$USER" != "root" ]]; then
    iconFG=27
    iconFG=11
    icon=$' '
    icon=$'󰫻'
  else
    # promptFG=8
    iconFG=1
    icon=$' '
    icon=$'󰫻'
  fi
  #Github Prompt
  local GS="$(git branch 2>/dev/null)"
  local GP=""
  local GP_l=""
  if [ -n "$GS" ]; then
    #Github Icon
    GI=""
    INFO=$(parse_git_branch)
    #Untracked files
    # Github Color
    GC=77
    GP="$LPD$(putFG 27)$GI$(putFG $promptFG)$RPD$OLD${INFO}$(putFG $promptFG)$ORD"
    GP_l="$(strip $GP)"
  fi
  # User Prompt
  local UP="$(putFG $promptFG)|$(putFG $iconFG)$icon$R$(putFG $promptFG)|"
  local UP_l="$(strip $UP)"
  # Line 1
  local L1="$(putFG $promptFG)"$'\u250C'"$L"

  # Workspace Icon
  local WSicon=""
  local WSIC=46
  # Workspace Prompt
  local WP=""
  [ -f '/home/parrot/.local/workspace.txt' ] && export WS="$(cat /home/parrot/.local/workspace.txt)"
  if [ -d "$WS" ]; then
    # Workspace Prompt
    WP="$L$LD$(putFG $WSIC)${WSicon} $(putFG 7)$(workspace)$(putFG $promptFG)$RD"
  fi
  WP="$(user)"
  local WP_l="$(strip "$WP")"

  # Directory propmt
  local DIR=""
  if [ -n "$WS" ] && [ -n "$(echo -n $PWD | grep $WS)" ]; then
    DIR=$(echo -n $PWD | sed -E "s#$WS##")
  elif [ -n "$(echo -n $PWD | grep "$HOME")" ]; then
    DIR=$(echo -n $PWD | sed -E "s#$HOME#󰀶#")
  else
    DIR=$PWD
  fi
  local DC=7
  local DP="$L$LD$(putFG $DC)$DIR$R$(putFG $promptFG)$RD"
  local DP_l="$(strip $DP)"
  
  local cols=$(tput cols)
  local chars=$(( cols - ${#DP_l} - ${#UP_l} - ${#GP_l} - ${#WP_l}))
  local line=""
  for ((i = 2; i < chars; i++)); do
    line+=$L
  done
  local ECFG=""
  local EP=""
  if [ $cmd_status -eq 0 ]; then
    # Error Color
    ECFG=14
    # Error Prompt
    EP=""
    # PS1="$L1$line$UP\n"$'\u2514\u2500'" $R"
  else
    # Error Color
    ECFG=196
    # Error Prompt
    EP="($(putFG $ECFG)${bold}[x]$R $cmd_status$(putFG $promptFG))"
    # PS1="$L1$line$UP\n"$'\u2514\u2500'"❨$(putFG 1)󰃤$R $status $(putFG $promptFG)❩$(putFG 1)$R "
  fi
  # Input Char
  local IC=""
  if [[ "$USER" != "root" ]]; then
    IC="$L╼ $(putFG $ECFG)$bold\$$R"
  else
    IC="$L╼ $(putFG $ECFG)${bold}#$R"
  fi
  # Line Union
  local LU=$'\u2514\u2500'
  # Prompt String 1
  PS1="$L1$WP$DP$GP$line$UP"$'\n'"$LU$EP$IC"
}

precmd
