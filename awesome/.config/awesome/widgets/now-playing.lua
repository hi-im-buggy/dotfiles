local awful = require("awful")

local now_playing = awful.widget.watch("playerctl metadata --format 'Now Playing: {{title}} - {{artist}}'", 1)

return now_playing
