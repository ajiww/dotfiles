local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Use specific shell
config.default_prog = {"/usr/bin/zsh", "-c", "cat ~/ascii-art.txt; exec zsh"}

-- Key bindings
config.keys = {
  {key = "t", mods = "CTRL|SHIFT", action = wezterm.action{ SpawnTab = "DefaultDomain" }},
  {key = "w", mods = "CTRL|SHIFT", action = wezterm.action{ CloseCurrentTab = { confirm = true }} },
  {key = 'Delete', action = wezterm.action.SendKey { key = 'Delete' }},
}
config.window_close_confirmation = "NeverPrompt" -- "AlwaysPrompt", "NeverPrompt", "ConfirmQuit"

-- It makes wezterm honor kitty keyboard protocol escape sequences that modify the keyboard encoding.
config.enable_kitty_keyboard = true
-- This helps Emacs see the difference between Tab and Ctrl-I
config.enable_csi_u_key_encoding = true

config.enable_wayland = true
-- Choose rendering
config.front_end = "OpenGL" -- GPU accelerated resterization
--config.front_end = "WebGpu" -- Newer GPU backend rendering
--config.front_end = "Software" -- CPU based rendering

-- Appearance
config.color_scheme = "Dracula"
config.font = wezterm.font("JetBrains Mono") -- "JetBrains Mono", "Ubuntu Mono"
config.font_size = 15.0

color = {
  dark = '#120b0f',
  amber = '#ffb86c',
  amber_light = '#bfa6a0',
  amber_strong = '#ff9f43',
  plum = '#3a1f2a',
  grape = '#f08080',
  orange = '#ffdab9',
}

-- Cursor styling
config.hide_mouse_cursor_when_typing = false
config.default_cursor_style = "SteadyBlock" -- "BlinkingBar", "BlinkingBlock", "BlinkingUnderline", "SteadyBar", "SteadyBlock", "SteadyUnderline"
config.cursor_blink_rate = 475
config.cursor_thickness = 2
-- Amber glow effect
config.colors = {
  cursor_bg = color.grape,
  cursor_border = color.amber_strong,
  cursor_fg = color.orange,
}

-- Window
wezterm.on("gui-startup", function(cmd)
  local mux = wezterm.mux
  local tab, pane, window = mux.spawn_window(cmd or {})
  local gui_window = window:gui_window() gui_window:toggle_fullscreen() -- maximize(), minimize(), toggle_fullscreen()
end)
-- If you are not using function above or using minimize() you can define the exact size here, but
-- the downside for using minimize() and maximize() are the gap on bottom and right side.
--config.initial_cols = 60
--config.initial_rows = 15

config.window_decorations = "RESIZE" -- "NONE", "TITLE", "RESIZE", "INTEGRATED_BUTTONS"
config.window_background_opacity = 0.90
config.window_background_gradient = {
  orientation = 'Horizontal', -- 'Horizontal', 'Vertical'
  colors = {color.dark, color.plum},
}
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_frame = {
  active_titlebar_bg = color.plum,
  inactive_titlebar_bg = color.dark,
}

config.use_resize_increments = true
config.inactive_pane_hsb = {
  saturation = 0.8,  -- reduce color intensity slightly
  brightness = 0.7,  -- dim without crushing blacks
}
config.text_background_opacity = 1.0

config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.colors.tab_bar = {
  background = color.dark,
  active_tab = {
    bg_color = color.plum,
    fg_color = color.amber,
    intensity = "Bold", -- "Normal", "Bold", "Half"
  },
  inactive_tab_hover = {
    bg_color = color.amber,
    fg_color = color.dark,
    intensity = "Normal",
  },
  inactive_tab = {
    bg_color = color.dark,
    fg_color = color.amber_light,
    intensity = "Half",
  },
  new_tab = {
    bg_color = color.dark,
    fg_color = color.amber,
    intensity = "Bold",
  },
  new_tab_hover = {
    bg_color = color.amber,
    fg_color = color.dark,
    intensity = "Normal",
  },
}

return config
