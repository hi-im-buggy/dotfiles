-- Theme library
local beautiful = require("beautiful")
-- OS library to get environment vars
local os = require("os")

local meta = {}

-- Set the theme
beautiful.init("/home/buggy/.config/awesome/theme.lua")

-- This is used later as the default terminal, editor, and visual editor to run.
meta.terminal = os.getenv("TERMINAL") or "/usr/bin/st"
meta.editor = os.getenv("EDITOR") or "/user/bin/nvim"
meta.visual = os.getenv("VISUAL") or (meta.terminal .. "-e" .. meta.editor)

-- Default modkey
meta.modkey = "Mod4"

return meta
