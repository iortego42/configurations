#!/bin/bash
 
ip_address=$(cat /home/cheras/.config/bin/target | awk '{print $1}') 
if [ $ip_address ]; then
  if (($(ping -c 1 $ip_address | head -n 2 | tail -n 1 | awk '{print $6}' | sed 's/ttl=//') <= 64)); then 
    echo "%{F#e51d1d}%{T3}什%{T2} %{F#ffffff}$ip_address%{u-} - "
  else
    echo "%{F#e51d1d}%{T3}什%{T2} %{F#ffffff}$ip_address%{u-} - "
  fi 
else
    echo "%{F#05adcb}%{T3}%{T2}%{F#ffffff} No target"
fi
