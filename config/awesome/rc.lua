-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
--local bling = require("bling")
--local rubato = require("rubato")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
--local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
--local battery_widget = require("battery-widget")
--local screenshot = require("screenshot")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
--require "ui"
require "autostart"
--require "bar"
--require "bar3"

-- Load Debian menu entries
--local debian = require("debian.menu")
local has_fdo, freedesktop = pcall(require, "freedesktop")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "there were some errors, but fuck them errors.",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
       in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "there were some errors, but fuck them errors.",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    --awful.layout.suit.floating,
    --awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    --awful.layout.suit.floating,
    --awful.layout.suit.fair,
    --awful.layout.suit.floating,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    awful.layout.suit.floating,
    -- awful.layout.suit.corner.se,
}

-- }}}
-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   --{ "restart", awesome.restart },
   --{ "quit", function() awesome.quit() end },
}

local menu_awesome = { "awesome", myawesomemenu, beautiful.awesome_icon }
local menu_terminal = { "open terminal", terminal }

if has_fdo then
    mymainmenu = freedesktop.menu.build({
        before = { menu_awesome },
        after =  { menu_terminal }
    })
else
    mymainmenu = awful.menu({
        items = {
                  menu_awesome,
                 -- { "Debian", debian.menu.Debian_menu.Debian },
                  menu_terminal,
                }
    })
end

--praisewidget = wibox.widget.textbox()
--praisewidget.text = ""

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
--mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- screen padding
	--awful.screen.padding(screen[s],{top = 24})

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    --s.padding_top = 24

    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    --awful.tag({ "4", "5", "6", }, screen[1], awful.layout.layouts[1])
    --awful.tag({ "1", "2", "3", }, screen[2], awful.layout.suit.tile.bottom)
    awful.tag({ "1", "2", "3", "4", "5", "6", }, s, awful.layout.layouts[1])
 


    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    --s.mytasklist = awful.widget.tasklist {
      --  screen  = s,
      --  filter  = awful.widget.tasklist.filter.currenttags,
      --  buttons = tasklist_buttons
    --}

-- {{{ Menu
    -- Create the wibox bis "end" alles auskommentieren um wibar zu deaktivieren
--    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
--    s.mywibox:setup {
--        layout = wibox.layout.align.horizontal,
--        { -- Left widgets
--            layout = wibox.layout.fixed.horizontal,
--            mylauncher,
--            --s.mytaglist,
--            s.mypromptbox,
--        },
--        --s.mytasklist,
--        s.mytaglist, -- Middle widget
--        { -- Right widgets
--            layout = wibox.layout.fixed.horizontal,
--            mykeyboardlayout,
--            wibox.widget.systray(),
--            mytextclock,
--            praisewidget, -- This line is new
--            --s.mylayoutbox,
--            battery_widget {
--            	ac = "AC",
--    		adapter = "BAT0",
--    		ac_prefix = "AC: ",
--    		battery_prefix = "Bat: ",ac_prefix = "AC: ",
--            	battery_prefix = "Bat: ",
--            	timeout = 10
--        },
--    }
--}
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Brightness

    awful.key({ }, "XF86MonBrightnessDown", function ()
        awful.util.spawn("xbacklight -dec 15") end),
    awful.key({ }, "XF86MonBrightnessUp", function ()
        awful.util.spawn("xbacklight -inc 15") end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            --awful.client.focus.history.previous()
    	awful.util.spawn("rofi -show window -show-icons") end,
              {description = "run rofi", group = "launcher"}),

            --if client.focus then
              --  client.focus:raise()
            --end
        --end,
        --{description = "go back", group = "client"}),

    -- Standard program
    --awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
      --        {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "y", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "y", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function ()
    awful.util.spawn("sh /home/axon/.config/rofi/launchers/type-4/launcher.sh") end,
              {description = "run rofi", group = "launcher"}),

    awful.key({ modkey },            "a",     function ()
    awful.util.spawn("sh /home/axon/.config/rofi/launchers/type-3/launcher.sh") end,
              {description = "run rofi-app-menu", group = "launcher"}),

    awful.key({ modkey },            "g",     function ()
    awful.util.spawn("sh /home/axon/.config/rofi/launchers/type-6/launcher.sh") end,
              {description = "run rofi type 6", group = "launcher"}),

awful.key({ modkey, "Shift" },            "s",     function ()
    awful.util.spawn("ksnip -s") end,
              {description = "take a screenshot", group = "tools"}),

    -- Prompt
    awful.key({ modkey },            "b",     function ()
    awful.util.spawn("firefox") end,
              {description = "brave", group = "applications"}),

    -- Prompt
    awful.key({ modkey, "Control" },            "+",     function ()
    awful.util.spawn("mocp -f") end,
              {description = "moc next", group = "moc"}),

    -- Scratchpad
--    awful.key({ modkey },            "a",     function ()
--    awful.util.spawn("kitty ") end,
--              {description = "scratchpad", group = "scratchpads"}),

    -- Prompt
    awful.key({ modkey, "Control" },            "ü",     function ()
    awful.util.spawn("mocp -r") end,
              {description = "moc previous", group = "moc"}),
             
    -- Prompt
    awful.key({ modkey },            "Return",     function ()
    awful.util.spawn("alacritty") end,
              {description = "alacritty", group = "applications"}),

  
    awful.key({ modkey },            "o",     function ()
    awful.util.spawn("nitrogen --restore") end,
              {description = "nitrogen", group = "applications"}),
    --awful.key({ modkey },            "Tab",     function ()
   -- awful.util.spawn("rofi -show window") end,
              --{description = "rofi window", group = "launcher"}),

    awful.key({ modkey },            "e",     function ()
    awful.util.spawn("nemo") end,
              {description = "nautilus", group = "applications"}),

    awful.key({ modkey },            "v",     function ()
    awful.util.spawn("alacritty -e ranger") end,
              {description = "rofi files", group = "launcher"}),

    awful.key({ modkey },            "ö",     function ()
    awful.util.spawn("mocp") end,
              {description = "mocp", group = "applications"}),

    awful.key({ modkey },            "+",     function ()
    awful.util.spawn("./.config/polybar/launch-bars/launch-top.sh") end,
              {description = "reload polybar", group = "applications"}),

    awful.key({ modkey, "Shift" },            "+",     function ()
    awful.util.spawn("pkill polybar") end,
              {description = "kill polybar", group = "applications"}),

    awful.key({ modkey },            "ü",     function ()
    awful.util.spawn("plank") end,
              {description = "launch plank dock", group = "applications"}),

    awful.key({ modkey, "Shift" },            "Ü",     function ()
    awful.util.spawn("pkill plank") end,
              {description = "kill the dock", group = "applications"}),

    awful.key({  },          "XF86AudioLowerVolume",     function ()
    awful.util.spawn("pactl -- set-sink-volume 0 -5%") end,
              {description = "lower volume", group = "media"}),
              
    awful.key({  },          "XF86AudioRaiseVolume",     function ()
    awful.util.spawn("pactl -- set-sink-volume 0 +5%") end,
              {description = "raise volume", group = "media"}),       
             
    awful.key({  },          "XF86AudioMute",     function ()
    awful.util.spawn("amixer set Master toggle") end,
              {description = "mute Audio", group = "media"}),

    awful.key({ modkey },          "d",     function ()
    awful.util.spawn("epiphany") end,
              {description = "To-Do list", group = "applications"}),

    awful.key({ modkey, "Shift" },          "d",     function ()
    awful.util.spawn("pkill epiphany") end,
              {description = "close To-Do list", group = "applications"}),

    awful.key({ modkey },          "f",     function ()
    awful.util.spawn("gtk-launch webapp-Notion2074") end,
              {description = "launch the Notion webapp", group = "applications"}),

    awful.key({ "Control", "Shift" },          "s",     function ()
    awful.util.spawn("killall -SIGUSR1 gpu-screen-recorder") end,
              {description = "Save the last 90 seconds", group = "applications"}),

    awful.key({ modkey, "Control" },            "p", function ()
    awful.util.spawn("./.config/rofi/powermenu/type-2/powermenu.sh") end,
              {description = "rofi powermenu", group = "system"}),

  
--    awful.key({ modkey },            "t",     function ()
--    awful.util.spawn("rofi -run-shell-command 'alacritty --hold {cmd}'") end,
--              {description = "rofi run", group = "launcher"}),

   -- awful.key({ modkey },            "t",     function ()
    --awful.util.spawn("terminal") end,
      --        {description = "terminal", group = "applications"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)


-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          --"kitty",
          "epiphany",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    { rule = { class = "alacritty" },
        properties = { opacity = 0.75 } },

   
    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },

    --exclude polybar from the border width rule defined in theme.lua

    { rule = { class = "Polybar" }, -- You might need to adjust the class name
        properties = { border_width = 0 } },

    { rule = { class = "latte-dock" }, -- You might need to adjust the class name
        properties = { border_width = 0 } },

    { rule = { class = "Plank" }, -- You might need to adjust the class name
        properties = { border_width = 0 } },

    { rule = { },
        properties = {   focus = awful.client.focus.filter,
                         raise = true,
                         keys = clientkeys,
                         buttons = clientbuttons,
                         screen = awful.screen.preferred,
                         placement = awful.placement.centered + awful.placement.no_overlap+awful.placement.no_offscreen
         }
        },
    
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,.
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("request::manage", function(client, context)

    if client.floating and context == "new" then
        client.placement = awful.placement.centered
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)

--	if c.class ~= "polybar" then
--		border_width = 0

    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            --awful.titlebar.widget.floatingbutton (c),
            --awful.titlebar.widget.maximizedbutton(c),
            --awful.titlebar.widget.stickybutton   (c),
            --awful.titlebar.widget.ontopbutton    (c),
            --awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

--client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
--client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

client.connect_signal("manage", function(c)
    if c.class ~= "Polybar, Plank" then
        c.shape = function(cr, w, h)
              gears.shape.rounded_rect(cr, w, h, 12)
        end
    end
end)



--awful.key({ modkey,}, "0", function() awful.spawn("nitrogen --restore")
--end)

-- Configure the hotkeys.
--        awful.key({ }, "Print", scrot_full,
--          {description = "Take a screenshot of entire screen", group = "screenshot"}),
--        awful.key({ modkey, }, "Print", scrot_selection,
--          {description = "Take a screenshot of selection", group = "screenshot"}),
--        awful.key({ "Shift" }, "Print", scrot_window,
--          {description = "Take a screenshot of focused window", group = "screenshot"}),
--        awful.key({ "Ctrl" }, "Print", scrot_delay,
--          {description = "Take a screenshot of delay", group = "screenshot"}),

--{ rule = { class = "polybar" },
--  properties = { border_width = 0 } }




