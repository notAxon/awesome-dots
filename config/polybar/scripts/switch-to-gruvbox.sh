#!/bin/bash

rm ~/.config/polybar/colorschemes/default-color

cp -r ~/.config/polybar/colorschemes/gruvbox ~/.config/polybar/colorschemes/default-color

source /home/axon/.config/polybar/launch.sh 
