local awful = require("awful")

local battery_widget = awful.widget.watch("acpi", 20, function(widget, stdout)
	for percentage in stdout:gmatch("%d*%%") do
		widget:set_text(" | Battery: " .. percentage .. " | ")
	end
end)

return battery_widget
