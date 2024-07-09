# Dotfiles of my AwesomeWM configuration

![the almighty rice (incomplete)](https://github.com/notAxon/awesome-dots/blob/main/screenshots/ksnip_20240108-113415.png)
![the almighty rice with the two-top-polybar config](https://github.com/notAxon/awesome-dots/blob/main/screenshots/ksnip_20240212-165653.png)

this only includes the most basic files to replicate my setup, such as 

+ configs for awesome
+ configs for alacritty
+ configs for rofi (straight-up stolen from [here](https://github.com/adi1090x/rofi))
+ an edited version of [pijulius' picom fork](https://github.com/pijulius/picom)
+ configs for polybar
+ spicetify (still wip)

>[!IMPORTANT]
>before using any of the files, make sure to have at least the most necessary software installed, unless you know what you're doing:

### cloning this repo:

> git clone https://github.com/notAxon/awesome-dots/ && cd awesome-dots

### basic stuff: 

> awesome rofi polybar alacritty nemo amixer ksnip 

### optional stuff:

> nitrogen neovim lxappearance 


all folders inside `belongs_in_config` belong, as the name implies, in the **.config** folder inside your `/home` directory. 

> cp -r /belongs_in_config/* \$HOME/.config

the fonts should be copied into `/usr/share/fonts/` for them to work properly, as they are required by *alacritty* and *polybar*

> sudo cp -r /used\ fonts/*.ttf /usr/share/fonts/

the GTK files are to be copied into `$/HOME/.themes` and `/$HOME/.icons` 

> unzip /gtk/.themes.tar.gz /\$HOME/.themes 
> unzip /gtk/.icons.tar.gz /\$HOME/.icons

### the fancy-looking terminal programs I adore:

+ moc (music on console), with darkdot theme (available through most package-managers)
+ [pipes.sh](https://github.com/pipeseroni/pipes.sh)
+ [cava](https://github.com/karlstav/cava)
+ neofetch (no instructions necessary)

#### a link to my wallpaper collection can be found [here](https://github.com/notAxon/wallpapers)

[first wallpaper](https://github.com/notAxon/wallpapers/blob/main/Anime/Screenshot_499.png) [second wallpaper](https://github.com/notAxon/wallpapers/blob/main/catppuccin/Pink_Flowers_Photograph_by_Lisa_Fotios.jpeg)

### Notes related to AwesomeWM

#### Keybinds

| Command | Description |
| --- | --- |
| `Super Enter` | open Alacritty |
| `Super Shift c` | close window |
| `Super Shift y` | toggle tiling |
| `Super o` | restore wallpaper (nitrogen --restore) |
| `Super Shift +` | kill polybar |
| `Super +` | reload polybar |
| `Super Shift s` | take a screenshot using ksnip |
| `Super r` | run rofi |
| `Super a` | run rofi appmenu |
| `Super Ctrl p` | run rofi powermenu |
| `Super e` | launch nemo file manager |
| `Super b` | launch firefox |
| `Super Shift y` | toggle tiling |

>[!IMPORTANT] all basic keybinds can be looked up by pressing `super + s`

### Notes related to Polybar

this polybar config is divided into 5 subfolders:

1. `/bar-configs`
  includes individual files each defining a different bar. to use another bar than `two-top` (shown in the second screenshot), edit `/awesome/rc.lua`.

2. `/modules`
   contains all modules

3. `/launch-bars`
   include executable scripts that launch the individual bars, the preferred bar can be selected in awesomeWMs `rc.lua`

4. `/colorschemes`
   contains all colorschemes aswell as `default-color`, the only file being loaded by polybar. by default, this file is a renamed copy of the `catppuccin` file, to apply a different theme, delete `default-colors` before copying and renaming another theme, such as `everforest`.

5. `scripts`
   contains the scripts, obviously



### Screenshots

![neovim, cava, pipes.sh and mocp](https://github.com/notAxon/awesome-dots/blob/main/screenshots/ksnip_20240401-093013.png)
![neofetch, cava and mocp](https://github.com/notAxon/awesome-dots/blob/main/screenshots/ksnip_20240401-091251.png)






