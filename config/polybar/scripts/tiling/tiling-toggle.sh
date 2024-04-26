#!/bin/sh
#
TOGGLE=$HOME/.config/polybar/scripts/tiling/tiling-toggle.txt

if [ ! -e $TOGGLE]; then
    touch $TOGGLE
  awesome-client 'require("awful").layout.set(require("awful").layout.suit.corner.nw)'
  
else
  rm $TOGGLE
  awesome-client 'require("awful").layout.set(require("awful").layout.suit.floating)'
fi 
