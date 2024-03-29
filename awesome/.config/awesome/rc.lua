-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Error handling
require("main.error-handling")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- Global table for main configuration
local rc = {}

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup")

rc.vars = require("main.user-vars")

terminal = rc.vars.terminal
editor = rc.vars.editor
visual = rc.vars.visual

modkey = rc.vars.modkey

local main = {
    layout = require("main.layout"),
	menu = require("main.menu")
}

menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- {{{ Wibar and Widgets
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Music player widget
local now_playing = require("widgets.now-playing")

-- Battery widget
local battery_widget = require("widgets.battery")

-- Volume widget
local volume_widget = require("widgets.volume")

-- Create a wibox for each screen and add it
local taglist = require("widgets.taglist")
local tasklist = require("widgets.tasklist")

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
    s.mytaglist = taglist(s)

    -- Create a tasklist widget
	s.mytasklist = tasklist(s)

    -- Create the wibox
	s.mywibox = awful.wibar({
		position = "top",
		screen = s,
		shape = function(cr, w, h)
			gears.shape.rounded_rect(cr, w, h, 0)
		end
	})

    -- Create the systray
    s.systray = wibox.widget.systray()
    s.systray.visible = false

	-- Create the calendar
	local month_calendar = awful.widget.calendar_popup.month()
	month_calendar:attach( mytextclock, 'tr' )

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        -- Left widgets
		{
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
		-- Middle widgets
        s.mytasklist,
        -- Right widgets
		{
	    spacing = 6,
		layout = wibox.layout.fixed.horizontal,
		now_playing,
		s.systray,
		-- network,
		volume_widget,
		battery_widget,
		mytextclock,
		s.mylayoutbox,
        },
    }
end)
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

	-- Focus by direction
	awful.key({ modkey }, "j", function ()
		awful.client.focus.bydirection("down")
		if client.focus then client.focus:raise() end
	end, {description = "focus client below current window", group = "client"}),
	awful.key({ modkey }, "k", function ()
		awful.client.focus.bydirection("up")
		if client.focus then client.focus:raise() end
	end, {description = "focus client above current window", group = "client"}),
	awful.key({ modkey }, "l", function ()
		awful.client.focus.bydirection("right")
		if client.focus then client.focus:raise() end
	end, {description = "focus client to the right of current window", group = "client"}),
	awful.key({ modkey }, "h", function ()
		awful.client.focus.bydirection("left")
		if client.focus then client.focus:raise() end
	end, {description = "focus client to the left of current window", group = "client"}),

	awful.key({ modkey }, "w", function ()
	awful.util.spawn("rofi -show window -fake-transparency")
    end, {description = "rofi window switcher", group = "launcher"}),

  -- Lockscreen and systray

    awful.key({ modkey, "Control" , "Shift"}, "l", function ()
	awful.util.spawn("i3lock-fancy-rapid 3 10") end,
	{description = "lock the screen", group = "laptop"}),

    awful.key({ modkey }, "=", function ()
	awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible end,
	{description = "Toggle systray visibility", group = "custom"}),

  -- Brightness

    awful.key({	modkey,		 }, "[", function ()
        awful.util.spawn("light -U 5") end,
	{description = "decrease screen brightness", group = "laptop"}),
    awful.key({	modkey,		 }, "]", function ()
        awful.util.spawn("light -A 5") end,
	{description = "increase screen brightness", group = "laptop"}),

    awful.key({			 }, "XF86MonBrightnessDown", function ()
        awful.util.spawn("light -U 5") end,
	{description = "decrease screen brightness", group = "laptop"}),
    awful.key({			 }, "XF86MonBrightnessUp", function ()
        awful.util.spawn("light -A 5") end,
	{description = "increase screen brightness", group = "laptop"}),

    -- Keyboard backlight
    awful.key({	modkey,	"Control" }, "[", function ()
        awful.util.spawn("light -U 35 -s sysfs/leds/asus::kbd_backlight") end,
	{description = "decrease keyboard backlight", group = "laptop"}),
    awful.key({	modkey, "Control" }, "]", function ()
        awful.util.spawn("light -A 35 -s sysfs/leds/asus::kbd_backlight") end,
	{description = "increase keyboard backlight", group = "laptop"}),
	
    -- Volume
    awful.key({	modkey,	"Shift"	}, "[", function ()
	awful.util.spawn("pactl set-sink-volume %s -5%%") end,
	{description = "decrease audio volume", group = "laptop"}),
    awful.key({			}, "XF86AudioRaiseVolume", function ()
	awful.util.spawn("pactl set-sink-volume %s +5%%") end,
	{description = "increase audio volume", group = "laptop"}),

    awful.key({	modkey,	"Shift"	}, "]", function ()
	awful.util.spawn("pactl set-sink-volume %s -5%%") end,
	{description = "decrease audio volume", group = "laptop"}),
    awful.key({			}, "XF86AudioRaiseVolume", function ()
	awful.util.spawn("pactl set-sink-volume %s +5%%") end,
	{description = "increase audio volume", group = "laptop"}),

    -- Media player
    awful.key({	modkey,	"Shift"	}, "p", function ()
	awful.util.spawn("playerctl play-pause") end,
	{description = "increase audio volume", group = "laptop"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey,           }, "c", awful.placement.centered,
	      {description = "center the focused floating client", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () main.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () main.layout.inc(-1)                end,
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
		awful.util.spawn("rofi -show combi -combi-modi \"window,drun,run\" -fake-transparency")
	end, {description = "rofi", group = "rofi launcher"}),

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
        {description = "(un)maximize horizontally", group = "client"}),

	-- Miscellaneous
	awful.key({ modkey, "Shift"}, "u", function ()
	awful.util.spawn_with_shell("scripts/unicode.py | rofi -dmenu -i -p unicode | cut -d$'\t' -f2 | xclip -r -selection clipboard; xdotool key ctrl+v")
    end, {description = "unicode selector", group = "miscellaneous"}),

	awful.key({ modkey, "Shift"}, "s", function ()
	awful.util.spawn_with_shell("maim -s | tee ~/Pictures/Screenshots/$(date +%s).png | xclip -selection clipboard -t image/png")
	end, {description = "teiler", group = "miscellaneous"}),

	awful.key({ modkey, "Shift"}, "e", function ()
	awful.util.spawn_with_shell("splatmoji copypaste")
    end, {description = "emoji selector", group = "miscellaneous"}),

	awful.key({ modkey, "Shift"}, "n", function ()
	awful.util.spawn_with_shell("scripts/content-ls.sh Notes/** | rofi -dmenu -i -p notes | scripts/launch-nvim.sh")
	end, {description = "nv style finder", group = "miscellaneous"})

)

for i = 1, 10 do
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
                     placement = awful.placement.centered+awful.placement.no_overlap+awful.placement.no_offscreen
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
          "feh",
          "mpv",
          "qjackctl",
          "alacritty",
          "Pavucontrol",
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
      }, properties = { floating = true,
			placement = awful.placement.centered
  }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end
	c.shape = function(cr,w,h)
		gears.shape.rounded_rect(cr,w,h,8)
	end
	if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
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

-- Commenting these lines out to disable titlebar
--     awful.titlebar(c) : setup {
--         { -- Left
--             awful.titlebar.widget.iconwidget(c),
--             buttons = buttons,
--             layout  = wibox.layout.fixed.horizontal
--         },
--         { -- Middle
--             { -- Title
--                 align  = "center",
--                 widget = awful.titlebar.widget.titlewidget(c)
--             },
--             buttons = buttons,
--             layout  = wibox.layout.flex.horizontal
--         },
--         { -- Right
--             awful.titlebar.widget.floatingbutton (c),
--             awful.titlebar.widget.maximizedbutton(c),
--             awful.titlebar.widget.stickybutton   (c),
--             awful.titlebar.widget.ontopbutton    (c),
--             awful.titlebar.widget.closebutton    (c),
--             layout = wibox.layout.fixed.horizontal()
--         },
--         layout = wibox.layout.align.horizontal
--     }
--
--     Apparently this end statement is important to the doc structure, don't delete it
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- Autostarts {{{
awful.spawn.with_shell("picom -b")
awful.spawn.with_shell("nm-applet &")
-- awful.spawn.with_shell("variety &")
awful.spawn.with_shell("ibus-daemon -d")
-- }}}
