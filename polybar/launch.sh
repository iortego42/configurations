#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

## Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

## Launch

## custom.ini
polybar metropolis -c ~/.config/polybar/main.ini &
polybar hackthebox -c ~/.config/polybar/main.ini &
polybar target -c ~/.config/polybar/main.ini &

## internal.ini
polybar ethernet -c ~/.config/polybar/main.ini &
polybar cpu -c ~/.config/polybar/main.ini &
polybar memory -c ~/.config/polybar/main.ini &

## essentials.ini
polybar onoff_menu -c ~/.config/polybar/main.ini &
#polybar battery -c ~/.config/polybar/main.ini &

## workspace.ini
polybar primary -c ~/.config/polybar/workspace.ini &
