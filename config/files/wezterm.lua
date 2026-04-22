local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local is_macos = wezterm.target_triple:find("apple") ~= nil
local is_linux = wezterm.target_triple:find("linux") ~= nil

local MOVE_MOD = "ALT"
local RESIZE_MOD = "ALT|SHIFT"

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

config.xcursor_theme = "Adwaita"
config.color_scheme = mode == "dark" and "Afterglow" or "Builtin Solarized Light"

config.default_cwd = os.getenv("HOME")

config.window_background_opacity = 0.9
config.window_decorations = "NONE"

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.use_fancy_tab_bar = false

local function is_vim(pane)
  return pane:get_user_vars().IS_NVIM == 'true'
end

local direction_keys = {
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}

local function split_nav(resize_or_move, key)
  local mods = resize_or_move == 'resize' and RESIZE_MOD or MOVE_MOD

  return {
    key = key,
    mods = mods,
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        win:perform_action({
          SendKey = { key = key, mods = mods },
        }, pane)
      else
        if resize_or_move == 'resize' then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end

local function toggle_term()
  return {
    key = ";",
    mods = "CTRL",
    action = wezterm.action_callback(function(window, pane)
      local tab = pane:tab()
      local panes_with_info = tab:panes_with_info()

      local have_only_one = #tab:panes() == 1
      if have_only_one then
        pane:split({ direction = "Bottom" })
        return
      end

      local pane_is_zoomed = false
      for _, pane_info in ipairs(panes_with_info) do
        if pane_info.is_active then
          pane_is_zoomed = pane_info.is_zoomed
          break
        end
      end

      if pane_is_zoomed then
        tab:set_zoomed(false)
        window:perform_action({ ActivatePaneDirection = 'Down' }, pane)
      else
        window:perform_action({ ActivatePaneDirection = 'Up' }, pane)
        tab:set_zoomed(true)
      end
    end),
  }
end

local function tab(num)
  return {
    key = tostring(num),
    mods = 'CTRL',
    action = wezterm.action.ActivateTab(num - 1),
  }
end

local keys = {
  { key = 'Enter', mods = 'CTRL', action = wezterm.action.ToggleFullScreen },

  split_nav('move', 'h'),
  split_nav('move', 'j'),
  split_nav('move', 'k'),
  split_nav('move', 'l'),

  split_nav('resize', 'h'),
  split_nav('resize', 'j'),
  split_nav('resize', 'k'),
  split_nav('resize', 'l'),

  toggle_term(),

  {
    key = "\\",
    mods = "CTRL",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = 'H',
    mods = 'CTRL',
    action = wezterm.action.ActivateCopyMode,
  },
}

for i = 1, 5 do
  table.insert(keys, tab(i))
end

config.keys = keys

return config
