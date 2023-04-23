#!/bin/sh

IP=$(ifconfig | grep -A 4 "utun" | grep "inet " | cut -d ' ' -f 2)
ICON=""
ICONBACKCOLOR=0xff000000
if [ "$IP" ]; then
	IP="<$IP>"
	ICON="󰢏"
	FONT="Hack Nerd Font:Bold:24.0"
	LABELCOLOR=0xff000000
	ICONBACKCOLOR=0xffcfe0df
	ICONCOLOR=0xff707070
	Y=0
	H=30
	BW=11
else
	IP="->"
	LABELCOLOR=0xb7555555
	ICONCOLOR=0xffcfe0df
	ICONBACKCOLOR=0xff0065ef
	FONT="Hack Nerd Font:Bold:19.0"
	Y=0
	H=29
	BW=6
fi

sketchybar --set $NAME label="$IP" label.color="$LABELCOLOR" \
					   icon="$ICON" icon.color="$ICONCOLOR" icon.background.color=$ICONBACKCOLOR \
					   icon.background.corner_radius=16 icon.y_offset=$Y icon.background.height="$H" \
					   icon.background.border_width="$BW" \
					   icon.font="$FONT" icon.padding_left=5

