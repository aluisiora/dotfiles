-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.front_end = "WebGpu"
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font_with_fallback({
	{ family = "Fira Code" },
	{ family = "Symbols Nerd Font Mono", scale = 0.75 },
})
config.font_size = 12.0
config.line_height = 1.1
config.enable_tab_bar = false
config.enable_scroll_bar = false
config.audible_bell = "Disabled"
config.scrollback_lines = 6000
config.native_macos_fullscreen_mode = true

config.window_padding = {
	left = 4,
	right = 1,
	top = 5,
	bottom = 1,
}

-- and finally, return the configuration to wezterm
return config
