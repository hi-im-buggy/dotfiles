local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local volume_widget = wibox.widget {
	{
		id     = "mycommandwatch",
		widget = awful.widget.watch("pamixer --get-volume-human", 1, function(widget, stdout)
			for line in stdout:gmatch("[^\r\n]+") do
				if line:match("muted") then
					line = "[ M ]"
				end
				widget:set_text("Vol: " .. line)
			end
		end),
	},
	layout = wibox.layout.stack,

	is_muted = false,
	toggle_mute = (function()
		if is_muted then
			awful.spawn.easy_async("pamixer --unmute")
			is_muted = false
		else
			awful.spawn.easy_async("pamixer --mute")
			is_muted = true
		end
	end),
	increase_volume = function()
		awful.spawn.easy_async("pamixer --increase 5")
	end,
	decrease_volume = function()
		awful.spawn.easy_async("pamixer --decrease 5")
	end,
	spawn_gui = function()
		awful.util.spawn_with_shell("pavucontrol")
	end,
}

volume_widget:buttons(gears.table.join(
	awful.button({ }, 1, volume_widget.toggle_mute),
	awful.button({ }, 3, volume_widget.spawn_gui),
	awful.button({ }, 4, volume_widget.increase_volume),
	awful.button({ }, 5, volume_widget.decrease_volume)
))

return volume_widget
