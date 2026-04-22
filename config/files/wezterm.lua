-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- config builder
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


-- color scheme and cursor theme
config.xcursor_theme = "Adwaita"
config.color_scheme = mode == "dark" and "Afterglow" or "Unikitty Light (base16)"


-- Default working directory
config.default_cwd = os.getenv("HOME")

-- window background opacity
config.window_background_opacity = 0.9
config.window_decorations = "NONE"

-- Tabs
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.use_fancy_tab_bar = false

-- return the configuration to wezterm
return config
