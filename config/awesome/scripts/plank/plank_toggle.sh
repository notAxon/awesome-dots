#!/usr/bin/sh
#
TOGGLE=$HOME/.config/awesome/scripts/plank/toggle.txt

if [ ! -e $TOGGLE ]; then
  touch $TOGGLE

else
  rm $TOGGLE

fi

