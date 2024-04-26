#!/bin/bash

rm ~/.config/polybar/colorschemes/default-color

cp -r ~/.config/polybar/colorschemes/gruvbox ~/.config/polybar/colorschemes/default-color

rm ~/.config/awesome/default/theme.lua

cp r ~/.config/awesome/default/CATPPUCCIN.lua ~/.config/awesome/default/theme.lua




source /home/axon/.config/polybar/launch.sh 
