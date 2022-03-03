local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local now_playing = wibox.widget {
	{
		id = "myplayerwatch",
		widget = awful.widget.watch(
		"playerctl metadata -p 'spotify' --format ' {{title}} - {{artist}}'", 1)
	},
	layout = wibox.layout.stack,
	
	toggle_play_pause = (function()
		awful.spawn.easy_async("playerctl -p 'spotify' play-pause")
	end),
}

now_playing:buttons(gears.table.join(
	awful.button({ }, 1, now_playing.toggle_play_pause)
))

return now_playing
