#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

## Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

## Launch

## custom.ini
polybar metropolis -c ~/.config/polybar/custom.ini &
polybar hackthebox -c ~/.config/polybar/custom.ini &
polybar target -c ~/.config/polybar/custom.ini &

## internal.ini
polybar ethernet -c ~/.config/polybar/internal.ini &
polybar cpu -c ~/.config/polybar/internal.ini &
polybar memory -c ~/.config/polybar/internal.ini &

## essentials.ini
polybar onoff_menu -c ~/.config/polybar/essentials.ini &
polybar battery -c ~/.config/polybar/essentials.ini &

## workspace.ini
polybar primary -c ~/.config/polybar/workspace.ini &
