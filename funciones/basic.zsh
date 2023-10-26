function settarget() {
  echo "$1" > /home/kali/.local/target.txt
  if [[ `pwd` =~ .*"/$1" ]]; then 
    echo "$(pwd)/$1" > /home/kali/.local/targetdir.txt
  else
    echo '' > /home/kali/.local/targetdir.txt
  fi
  export TARGET="$(cat /home/kali/.local/target.txt)"
  export TARGETDIR="$(cat /home/kali/.local/targetdir.txt)"
}

function cdtarget() {
  if [[ -d $TARGETDIR ]];then
    cd $TARGETDIR
  else
    echo >&2 '\033[31;1mERROR\033[0m: Target has not got a valid directory' 
  fi
}

function cleartarget() {
  echo "$1" > /home/kali/.local/target.txt
  export TARGET="$(cat /home/kali/.local/target.txt)"
}

function setdn() {
  echo "$1" > /home/kali/.local/dn.txt
  export DN="$(cat /home/kali/.local/dn.txt)"
}

function cleardn() {
  echo "$1" > /home/kali/.local/dn.txt
  export DN="$(cat /home/kali/.local/dn.txt)"
}

function setws() {
  if [ -d "$1" ]; then
    export WS="$(pwd)"
    export WS+="$1"
  else
    export WS="$(pwd)"
  fi
  echo "$WS" >  /home/kali/.local/workspace.txt
}

function cdws() {
  export WS=$(cat /home/kali/.local/workspace.txt)
  if [ -z $WS ]; then 
    echo "ERROR: No hay ningun espacio de trabajo"
  else
    cd $WS
  fi
}

function clearws() {
  echo "" > /home/kali/.local/workspace.txt
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


function litend() {
  local address="$1"
  local little_endian=""
  address=${address#0x}
  local num_bytes=$(( ${#address} / 2 ))

  for (( pos = num_bytes - 1; pos >= 0; pos-- )); do
    local byte="${address:$pos*2:2}"
    little_endian+="\\\\x$byte"
  done

  echo "${little_endian}"
}


function rot13() {
  echo "$@" | tr 'A-Za-z' 'N-ZA-Mn-za-m'
}

function mktarget() {
  mkdir -p $1/{nmap,content,exploits,Imgs}
}
