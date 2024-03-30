#!/bin/bash

#change the awesome theme.lua
mv ~/.config/awesome/default/theme.lua ~/.config/awesome/default/themeCATPPUCCIN.lua
mv ~/.config/awesome/default/themeEVERFOREST.lua ~/.config/awesome/default/theme.lua

#change the polybar config
mv ~/.config/polybar/config ~/.config/polybar/configCATPPUCCIN
mv ~/.config/polybar/configEVERFOREST ~/.config/polybar/config

#change the alacritty config
mv ~/.config/alacritty/alacritty.yml ~/.config/alacritty/alacrittyCATPPUCCIN.yml
mv ~/.config/alacritty/alacrittyEVERFOREST.yml ~/.config/alacritty/alacritty.yml

echo 'awesome.restart()' | awesome-client
nitrogen --restore

