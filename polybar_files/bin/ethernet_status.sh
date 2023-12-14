echo "%{T2}%{F#ffffff} $(/usr/sbin/ifconfig | grep "inet " | awk '{print $2}')%{u-}"
