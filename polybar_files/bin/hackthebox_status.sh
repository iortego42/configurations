IFACE=$(/usr/sbin/ifconfig | grep tun0 | awk '{print $1}' | tr -d ':')
 
if [ "$IFACE" = "tun0" ]; then
   echo "%{F#1bbf3e}%{T3} %{T2}%{F#ffffff}$(/usr/sbin/ifconfig tun0 | grep "inet " | awk '{print $2}')${u-}"
else
   echo "%{F#1bbf3e}%{T3} %{T2}%{u-}Disconnected"
fi
