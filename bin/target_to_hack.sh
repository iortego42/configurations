#!/bin/bash
 
ip_address=$(cat /home/cheras/.config/bin/target | awk '{print $1}')
machine_name=$(cat /home/cheras/.config/bin/target | awk '{print $2}')
 
if [ $ip_address ] && [ $machine_name ]; then
    echo "%{F#e51d1d}%{T3}什%{T2} %{F#ffffff}$ip_address%{u-} - $machine_name"
else
    echo "%{F#05adcb}%{T3}%{T2}%{F#ffffff} No target"
fi
