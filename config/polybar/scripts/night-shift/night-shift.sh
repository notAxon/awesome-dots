#!/bin/sh
# This shell script is PUBLIC DOMAIN. You may do whatever you want with it.

TOGGLE=$HOME/.config/polybar/scripts/night-shift/night-shift-toggle.txt

if [ ! -e $TOGGLE ]; then
    touch $TOGGLE
    xrandr --output Dp-1 --gamma 0.7:0.6:0.6
else
    rm $TOGGLE
xrandr --output DP-1 --gamma 1.0:1.0:1.0
fi

