local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- font
config.font = wezterm.font 'JetBrainsMono Nerd Font Mono'
config.font_size = 16.0

-- window
config.window_padding = { left = 4, right = 4, top = 4, bottom = 4 }
config.window_decorations = 'RESIZE'
config.native_macos_fullscreen_mode = true

-- behavior
config.audible_bell = 'Disabled'

-- tab bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.show_tab_index_in_tab_bar = false

-- colors: filename (without .toml) is the scheme name WezTerm uses
config.color_scheme_dirs = { os.getenv('HOME') .. '/.config/wezterm/colors' }
config.color_scheme = 'tinted-theming'

-- keybindings
config.keys = {
  -- tabs
  { key = 't',          mods = 'CMD',       action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'i',          mods = 'CMD|SHIFT',  action = act.PromptInputLine {
      description = 'Tab name:',
      action = wezterm.action_callback(function(window, pane, line)
        if line then window:active_tab():set_title(line) end
      end),
  }},
  { key = '[',          mods = 'CMD',       action = act.ActivateTabRelative(-1) },
  { key = ']',          mods = 'CMD',       action = act.ActivateTabRelative(1) },
  -- panes
  { key = 'Enter',      mods = 'CMD',       action = act.SplitPane { direction = 'Right', size = { Percent = 50 } } },
  { key = 'LeftArrow',  mods = 'CMD',       action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'CMD',       action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'CMD',       action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'CMD',       action = act.ActivatePaneDirection 'Down' },
  { key = 'LeftArrow',  mods = 'CMD|SHIFT', action = act.RotatePanes 'CounterClockwise' },
  { key = 'RightArrow', mods = 'CMD|SHIFT', action = act.RotatePanes 'Clockwise' },
  { key = 'UpArrow',    mods = 'CMD|SHIFT', action = act.RotatePanes 'CounterClockwise' },
  { key = 'DownArrow',  mods = 'CMD|SHIFT', action = act.RotatePanes 'Clockwise' },
  -- layout
  { key = 'f',          mods = 'CMD|SHIFT', action = act.TogglePaneZoomState },
}

return config
