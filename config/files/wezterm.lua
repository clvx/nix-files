-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Afterglow'

-- Default working directory
config.default_cwd = "/home/clvx"

-- window background opacity
config.window_background_opacity = 0.9
config.window_decorations = "NONE"

-- Tabs
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.use_fancy_tab_bar = false

-- and finally, return the configuration to wezterm
return config
