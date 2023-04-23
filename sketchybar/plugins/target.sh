 #!/bin/sh

TARGET="$(cat '/Users/nachh/.local/target.txt')"
ICON=""
if [ -z "$TARGET" ]; then
	LABELCOLOR=0xff404030
	TARGET="-> No Target"
	ICONBACKCOLOR="0xffeadf0c"
	ICONCOLOR=0xff000000
else
	TARGET="$(echo $TARGET | sed 's/^/-> /')"
	LABELCOLOR=0xff000000
	ICONBACKCOLOR="0xffeadf0c"
	ICONCOLOR=0xff000000
fi
FONT="Hack Nerd Font:Bold:20.0"
Y=1
H=27
BW=1

sketchybar --set $NAME label="$TARGET" label.color="$LABELCOLOR" \
					   icon="$ICON" icon.color="$ICONCOLOR" icon.background.color=$ICONBACKCOLOR \
					   icon.background.corner_radius=16 icon.y_offset=$Y icon.background.height="$H" \
					   icon.background.border_width="$BW" icon.background.border_color=0xff000000 \
					   icon.font="$FONT" icon.padding_right=3 icon.padding_left=4


