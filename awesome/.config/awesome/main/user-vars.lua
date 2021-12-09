-- Theme library
local beautiful = require("beautiful")
-- OS library to get environment vars
local os = require("os")

local meta = {}

-- Set the theme
beautiful.init("/home/buggy/.config/awesome/theme.lua")

-- This is used later as the default terminal, editor, and visual editor to run.
meta.terminal = os.getenv("TERMINAL") or "/usr/bin/kitty"
meta.editor = os.getenv("EDITOR") or "/user/bin/kitty"
meta.visual = os.getenv("VISUAL") or (terminal .. "-e" .. editor)

-- Default modkey
meta.modkey = "Mod4"

return meta
