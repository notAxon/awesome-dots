#!/bin/sh
#
TOGGLE=$HOME/.config/polybar/scripts/focusmode/toggle.txt
AWESOMEPATH=$HOME/.config/awesome

if [ ! -e $TOGGLE ]; then
    touch $TOGGLE
  mv $AWESOMEPATH/rc.lua $AWESOMEPATH/unfocus.lua 
  mv $AWESOMEPATH/minimal.lua $AWESOMEPATH/rc.lua 
  echo 'awesome.restart()' | awesome-client
  
else
  rm $TOGGLE
  mv $AWESOMEPATH/rc.lua $AWESOMEPATH/minimal.lua 
  mv $AWESOMEPATH/unfocus.lua $AWESOMEPATH/rc.lua  
  echo 'awesome.restart()' | awesome-client
fi 
