-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

local function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return "Dark"
end

local function is_dark(appearance)
  return appearance:find("Dark") ~= nil
end

local function write_appearance_file(mode)
  local home = os.getenv("HOME")
  if not home then
    return
  end

  local path = home .. "/.cache/wezterm-appearance"
  local f = io.open(path, "w")
  if f then
    f:write(mode)
    f:close()
  end
end

local appearance = get_appearance()
local mode = is_dark(appearance) and "dark" or "light"

write_appearance_file(mode)


-- This is where you actually apply your config choices

config.xcursor_theme = "Adwaita"

-- For example, changing the color scheme:
config.color_scheme = mode == "dark" and "Afterglow" or "Builtin Solarized Light"


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
