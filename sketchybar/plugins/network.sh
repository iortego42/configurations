#!/bin/sh

MON=$(ifconfig | grep 'en0' | grep -o 'PROMISC')
IP=$(ifconfig | grep -A 4 "en0" | grep "inet " | cut -d ' ' -f 2)
STATUS=$(ifconfig | grep -A 4 "en0" | grep "status" | grep -o inactive)
ICON=""
ICONBACKCOLOR=0xff000000

if [ "$IP" ] && [ -z $STATUS ]; then
	ICON="󱄙"
	LABELCOLOR=0xff000000
	ICONCOLOR=0xffcfe0df
	Y=-1
else
	IP="Disconnected"
	LABELCOLOR=0xb7555555
	ICONCOLOR=0xffcfe0df
	ICONBACKCOLOR=0xffaf3030
fi
if [ "$MON" ]; then
	ICON='󰐷'
	IP="Capturing..."
	LABELCOLOR=0xff000000
	ICONCOLOR=0xff47ef22
	ICONBACKCOLOR=0xff000000
	Y=0
fi	

sketchybar --set $NAME label="$IP" label.color="$LABELCOLOR" \
					   icon="$ICON" icon.color="$ICONCOLOR" icon.background.color=$ICONBACKCOLOR \
					   icon.background.corner_radius=10 icon.y_offset=$Y icon.background.height=23 \
					   icon.background.border_width=3 icon.padding_left=5
