--Autostart Applications
local awful = require "awful"


--awful.spawn.with_shell("compton")
awful.spawn.with_shell("~/.config/arandr/default-layoutLANDSCAPE.sh")
--awful.spawn.with_shell("feh -z --bg-fill /home/axon/VagabondWallpaper")
--awful.spawn.with_shell("~/.config/awesome/nitrogenRestore.sh")
awful.spawn.with_shell("picom -b --config ~/.config/picom/picom.conf")
awful.spawn.with_shell("xrandr --output DisplayPort-0 --mode 1920x1080 --rate 120.00")
--awful.spawn.with_shell("feh --bg-scale ~/nordic-wallpapers/wallpapers/ign_evening.png")
--awful.spawn.with_shell("feh --bg-scale ~/Bilder/catppuccin")
--awful.spawn.with_shell("latte-dock")
--awful.spawn.with_shell("xrandr --output Displayport-0 --mode 1920x1080 --rate 144.00")
--awful.spawn.with_shell("picom --animations --animation-for-open-window fly-in -b --experimental-backends --config ~/.config/picom/picom.conf")
awful.spawn.with_shell("nitrogen --restore")
--awful.spawn.with_shell(".~/.config/eww/launch/launcheww.sh")
awful.spawn.with_shell("fcitx")

--launch polybar bars
--awful.spawn.with_shell("~/.config/polybar/launch-bars/launch.sh")
--awful.spawn.with_shell("~/.config/polybar/launch-bars/launch-less-wide.sh")
--awful.spawn.with_shell("~/.config/polybar/launch-bars/launchMultiple.sh")
--awful.spawn.with_shell("~/.config/polybar/launch-bars/launch.sh")
--awful.spawn.with_shell("~/.config/polybar/launch-bars/launch-multiple.sh")
--awful.spawn.with_shell("~/.config/polybar/launch-bars/launch-twotop.sh")
awful.spawn.with_shell("~/.config/polybar/launch-bars/launch-top.sh")
--awful.spawn.with_shell("~/.config/polybar/launch-bars/launch-top-2.sh")
awful.spawn.with_shell("polkit-gnome")
awful.spawn.with_shell("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
awful.spawn.with_shell("~/.config/gpu-screen-recorder/scripts/start-replay.sh")

