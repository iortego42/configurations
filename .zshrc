
function settarget() {
  echo "$1" > /Users/nachh/.local/target.txt
  export TARGET="$(cat /Users/nachh/.local/target.txt)"
}

function cleartarget() {
  echo "$1" > /Users/nachh/.local/target.txt
  export TARGET="$(cat /Users/nachh/.local/target.txt)"
}

function setws() {
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
# export JAVA_HOME="$(/usr/libexec/java_home)"

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
# Ruby Version Manager
export PATH="$HOME/.rvm/bin:$PATH"
# BINARIOS PROPIOS
export PATH="$HOME/.config/bin:$PATH"
# FINDUTILS
export PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"
#VMWARE OVF TOOLS
export PATH="$PATH:/Applications/VMware OVF Tool"
#PIPx Binarios
export PATH="$PATH:$HOME/.local/bin"
#Binarios Arch64
export PATH="$PATH:/usr/local/opt/brew/bin"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
# alias
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
#
#-------/ CUSTOM ALIASES /-------
#
alias ls='ls -F --color=auto'
alias ll='lsd -lhF --group-dirs=first'
alias la='lsd -laF --group-dirs=first'
alias l='lsd -F --group-dirs=first'

#####################################################
# Auto completion / suggestion
# Mixing zsh-autocomplete and zsh-autosuggestions
# Requires: zsh-autocomplete (custom packaging by Parrot Team)
# Jobs: suggest files / foldername / histsory bellow the prompt
# Requires: zsh-autosuggestions (packaging by Debian Team)
# Jobs: Fish-like suggestion for command history
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Select all suggestion instead of top on result only
zstyle ':autocomplete:tab:*' insert-unambiguous yes
zstyle ':autocomplete:tab:*' widget-style menu-select
zstyle ':autocomplete:*' min-input 2
bindkey $key[Up] up-line-or-history
bindkey $key[Down] down-line-or-history


##################################################
# Fish like syntax highlighting
# Requires "zsh-syntax-highlighting" from apt


# Save type history for completion and easier life
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
setopt histignorealldups sharehistory

# Useful alias for benchmarking programs
# require install package "time" sudo apt install time
# alias time="/usr/bin/time -f '\t%E real,\t%U user,\t%S sys,\t%K amem,\t%M mmem'\
#

source ~/.promptrc.sh
