local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local capacity_file = '/sys/class/power_supply/BAT0/capacity'
local plugged_file = '/sys/class/power_supply/AC0/online'

local battery_widget = wibox.widget {
	-- {
	-- 	id            = "myprogressbar",
	-- 	min_value     = 0,
	-- 	max_value     = 100,
	-- 	value         = 0,
	-- 	forced_width  = 50,
	-- 	widget        = wibox.widget.progressbar,
	-- },
	{
		id            = "mytextbox",
		text          = "[unset]",
		widget        = wibox.widget.textbox,
	},
	layout      = wibox.layout.stack,
	set_battery = function(self, val, plug)
		local numval = tonumber(val)
		local symbol = '  '
		local plugged = ''
		if tonumber(plug) == 1 then
			plugged = '+'
		end

		local pre = ""
		local post = ""
		if numval < 15 then
			pre = "<span color=\"#e01414\">"
			post = "</span>"
		end

		self.mytextbox.markup = pre .. symbol .. numval .. plugged .. "%" .. post
		-- self.myprogressbar.value  = tonumber(val)
	end,
}

gears.timer {
	timeout   = 10,
	call_now  = true,
	autostart = true,
	callback  = function()
		local capacity = io.lines(capacity_file)()
		local plugged = io.lines(plugged_file)()
		battery_widget:set_battery(capacity, plugged)
	end
}

return battery_widget
