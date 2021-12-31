local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

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

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    -- awful.tag({ "web", "code", "im", "music", "terms", "extra"}, s, awful.layout.layouts[1])
    awful.tag({ " I ", " II ", " III ", " IV ", " V ", " VI ", " VII ", " VIII ", " IX ", " X "}, s, main.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () main.layout.inc( 1) end),
    awful.button({ }, 3, function () main.layout.inc(-1) end),
    awful.button({ }, 4, function () main.layout.inc( 1) end),
    awful.button({ }, 5, function () main.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.noempty,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = tasklist_buttons,
        layout   = {
            spacing_widget = {
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place,
            },
            spacing = 1,
            layout  = wibox.layout.fixed.horizontal
        },
        -- Notice that there is *NO* wibox.wibox prefix, it is a template,
        -- not a widget instance.
        widget_template = {
            {
                wibox.widget.base.make_widget(),
                id            = 'background_role',
                widget        = wibox.container.background,
            },
            {
                {
                    id     = 'clienticon',
                    widget = awful.widget.clienticon,
                },
                margins = 2,
                widget  = wibox.container.margin
            },
            nil,
            create_callback = function(self, c, index, objects) --luacheck: no unused args
                self:get_children_by_id('clienticon')[1].client = c
            end,
            layout = wibox.layout.align.vertical,
        },
    }

    -- Create the wibox
    custom_shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 0)
    end
    s.mywibox = awful.wibar({ position = "top", screen = s, shape = custom_shape})

    -- Create the systray
    s.systray = wibox.widget.systray()
    s.systray.visible = false

    -- Create the calendar
    local month_calendar = awful.widget.calendar_popup.month()
    month_calendar:attach( mytextclock, 'tr' )

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        s.mytaglist,
        s.mypromptbox,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
    spacing = 6,
    layout = wibox.layout.fixed.horizontal,
    now_playing,
    s.systray,
    -- network,
    volume,
    battery,
    mytextclock,
    s.mylayoutbox,
},
    }
end)
