local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local volume_widget = wibox.widget {
	{
		id     = "mycommandwatch",
		widget = awful.widget.watch("pamixer --get-volume-human", 1, function(widget, stdout)
			for line in stdout:gmatch("[^\r\n]+") do
				widget:set_text("🔈" .. line)
			end
		end),
	},
	layout = wibox.layout.stack,
}

return volume_widget
