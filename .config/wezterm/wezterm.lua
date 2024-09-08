local wezterm = require("wezterm") -- imports wezterm api
local config = wezterm.config_builder() -- used to build a config to return to wezterm
local act = wezterm.action -- used by key bindings "action" values

-- Color Scheme
config.color_scheme = 'Tokyo Night Moon'

-- Flair
config.window_background_opacity = 0.9 -- 0 to 1
config.macos_window_background_blur = 10 -- 0 to 100
config.default_cursor_style = "SteadyUnderline"

-- Font
config.font = wezterm.font_with_fallback({ "JetBrainsMono Nerd Font Mono", "Monaco" })
config.font_size = 14.0

-- Remove title bar, but allows for resizing window (helps with tiling window "managers")
config.window_decorations = "RESIZE"

-- Shade Inactive Panes
config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.5,
}

-- Trust me, I know what Im doing (most of the time)
config.window_close_confirmation = "NeverPrompt"

-- =============================================================
-- KEY BINDINGS
-- =============================================================
-- https://wezfurlong.org/wezterm/config/keys.html#configuring-key-assignments
-- Hyper, Super, Meta, Cancel, Backspace, Tab, Clear, Enter, Shift, Escape,
-- LeftShift, RightShift, Control, LeftControl, RightControl, Alt, LeftAlt,
-- RightAlt, Menu, LeftMenu, RightMenu, Pause, CapsLock, VoidSymbol, PageUp,
-- PageDown, End, Home, LeftArrow, RightArrow, UpArrow, DownArrow, Select,
-- Print, Execute, PrintScreen, Insert, Delete, Help, LeftWindows, RightWindows,
-- Applications, Sleep, Numpad0, Numpad1, Numpad2, Numpad3, Numpad4, Numpad5, Numpad6,
-- Numpad7, Numpad8, Numpad9, Multiply, Add, Separator, Subtract, Decimal,
-- Divide, NumLock, ScrollLock, BrowserBack, BrowserForward, BrowserRefresh,
-- BrowserStop, BrowserSearch, BrowserFavorites, BrowserHome, VolumeMute,
-- VolumeDown, VolumeUp, MediaNextTrack, MediaPrevTrack, MediaStop, MediaPlayPause,
-- ApplicationLeftArrow, ApplicationRightArrow, ApplicationUpArrow, ApplicationDownArrow,
-- F1 through F24
-- =============================================================
config.keys = {
	-- create new tab (default: super t)
	{ key = "t", mods = "CTRL", action = act.SpawnTab("CurrentPaneDomain") },

	-- close current pane (default: super w)
	{ key = "w", mods = "CTRL", action = act.CloseCurrentPane({ confirm = false }) },

	-- zoom current pane (default: ctrl|shift z)
	{ key = "a", mods = "CTRL", action = act.TogglePaneZoomState },

	-- move focus to pane
	{ key = "h", mods = "CTRL", action = act.ActivatePaneDirection("Left") },
	{ key = "k", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "CTRL", action = act.ActivatePaneDirection("Right") },
	{ key = "j", mods = "CTRL", action = act.ActivatePaneDirection("Down") },
	-- this command brings up characters per pane for selection, like nvim leap
	-- colon is character after: h,j,k,l
	{ key = ";", mods = "CTRL", action = act.PaneSelect({ mode = "Activate" }) },

	-- rotate panes
	{ key = "[", mods = "CTRL", action = act.RotatePanes("CounterClockwise") },
	{ key = "]", mods = "CTRL", action = act.RotatePanes("Clockwise") },
	-- this command brings up characters per pane for selection, like nvim leap
	-- backslash is character after: [, ]
	{ key = "\\", mods = "CTRL", action = act.PaneSelect({ mode = "SwapWithActive" }) },

	-- split pane
	{ key = "h", mods = "CTRL|SHIFT", action = act.SplitPane({ direction = "Left" }) },
	{ key = "k", mods = "CTRL|SHIFT", action = act.SplitPane({ direction = "Up" }) },
	{ key = "l", mods = "CTRL|SHIFT", action = act.SplitPane({ direction = "Right" }) },
	{ key = "j", mods = "CTRL|SHIFT", action = act.SplitPane({ direction = "Down" }) },

	-- resize pane
	{ key = "LeftArrow", mods = "CTRL", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "UpArrow", mods = "CTRL", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "RightArrow", mods = "CTRL", action = act.AdjustPaneSize({ "Right", 1 }) },
	{ key = "DownArrow", mods = "CTRL", action = act.AdjustPaneSize({ "Down", 1 }) },
}

return config

-- ---------------------------------------
-- DEFAULTS
-- { key = "P", mods = "CTRL", action = act.ActivateCommandPalette },
-- { key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
-- { key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },

-- ---------------------------------------
-- KEY TABLE EXAMPLE
-- {
-- 	key = "p",
-- 	mods = "CTRL|ALT|SHIFT",
-- 	action = act.ActivateKeyTable({
-- 		name = "pane_management",
-- 		one_shot = false,
-- 	}),
-- },

-- config.key_tables = {
-- 	-- PANE MANAGEMENT MODE KEY MAP
-- 	pane_management = {
--
-- 		{ key = "Escape", action = "PopKeyTable" }, -- CANCEL MODE
-- 		{ key = "q", action = act.CloseCurrentPane({ confirm = false }) }, -- CLOSE
-- 		{ key = "x", action = act.CloseCurrentPane({ confirm = false }) }, -- CLOSE
--
-- 		-- ACTIVATE
-- 		{ key = "h", mods = "CTRL", action = act.ActivatePaneDirection("Left") },
-- 		{ key = "l", mods = "CTRL", action = act.ActivatePaneDirection("Right") },
-- 		{ key = "k", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
-- 		{ key = "j", mods = "CTRL", action = act.ActivatePaneDirection("Down") },
--
-- 		-- SPLIT
-- 		{ key = "h", mods = "CTRL|ALT", action = act.SplitPane({ direction = "Left" }) },
-- 		{ key = "k", mods = "CTRL|ALT", action = act.SplitPane({ direction = "Up" }) },
-- 		{ key = "l", mods = "CTRL|ALT", action = act.SplitPane({ direction = "Right" }) },
-- 		{ key = "j", mods = "CTRL|ALT", action = act.SplitPane({ direction = "Down" }) },
--
-- 		-- RESIZE
-- 		{ key = "h", mods = "CTRL|ALT|SUPER", action = act.AdjustPaneSize({ "Left", 1 }) },
-- 		{ key = "l", mods = "CTRL|ALT|SUPER", action = act.AdjustPaneSize({ "Right", 1 }) },
-- 		{ key = "k", mods = "CTRL|ALT|SUPER", action = act.AdjustPaneSize({ "Up", 1 }) },
-- 		{ key = "j", mods = "CTRL|ALT|SUPER", action = act.AdjustPaneSize({ "Down", 1 }) },
-- 	},
-- }

-- =============================================================
