#!/bin/bash

#change the awesome theme.lua
mv ~/.config/awesome/default/theme.lua ~/.config/awesome/default/themeEVERFOREST.lua
mv ~/.config/awesome/default/themeCATPPUCCIN.lua ~/.config/awesome/default/theme.lua

#change the polybar config
mv ~/.config/polybar/config ~/.config/polybar/configEVERFOREST
mv ~/.config/polybar/configCATPPUCCIN ~/.config/polybar/config

#change the alacritty config
mv ~/.config/alacritty/alacritty.yml ~/.config/alacritty/alacrittyEVERFOREST.yml
mv ~/.config/alacritty/alacrittyCATPPUCCIN.yml ~/.config/alacritty/alacritty.yml

echo 'awesome.restart()' | awesome-client
nitrogen --restore
