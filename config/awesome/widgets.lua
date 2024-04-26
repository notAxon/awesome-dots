local awful = require("awful")
local wibox = require("wibox")

-- Path to the icon and script
local ICON_PATH = "~/.config/awesome/icons/apple.png"
local SCRIPT_PATH = "~/.config/awesome/scripts/rofi/rofi-type-4-style-11.sh"

-- Function to create the widget
local function create_apple_logo(icon_path)
    local apple_logo = wibox.widget {
        {
            {
                image = icon_path,
                resize = true,
                widget = wibox.widget.imagebox,
            },
            margins = 4,
            widget = wibox.container.margin,
        },
        widget = wibox.container.background,
    }

    -- Set the color of the icon widget
    apple_logo.set_color = function(self, color)
        self:set_bg(color)
    end

    -- Execute the script on click
    apple_logo:connect_signal("button::press", function(_, _, _, button)
        if button == 1 then
            awful.spawn(SCRIPT_PATH)
        end
    end)

    return apple_logo
end

-- Example usage
local apple_logo = create_apple_logo(ICON_PATH)
apple_logo:set_color("#FF0000")  -- Set color to red

