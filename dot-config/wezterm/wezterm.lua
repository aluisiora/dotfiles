local wezterm = require("wezterm")
local config = {}

config.color_scheme = "GruvboxDark"
config.font = wezterm.font("JetBrains Mono")
config.font_size = 10.0
config.harfbuzz_features = { "calt = 0", "clig = 0", "liga = 0" }
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "TITLE|RESIZE"

-- TODO: wait for updates that will make wezterm work under wayland
local config_for_wayland = function(wez, c)
	c.window_decorations = "NONE"

	for _, gpu in ipairs(wez.gui.enumerate_gpus()) do
		if gpu.backend == "Vulkan" and gpu.device_type == "IntegratedGpu" then
			c.webgpu_preferred_adapter = gpu
			-- c.front_end = "WebGpu" -- FIX: wait until it is fixed
			c.front_end = "OpenGL"
			break
		end
	end

    return c
end

if os.getenv("XDG_SESSION_TYPE") == "wayland" then
	config = config_for_wayland(wezterm, config)
end

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
	options = { theme = "GruvboxDark" },
	sections = {
		tabline_a = { "mode" },
		tabline_b = { "workspace" },
		tabline_c = { " " },
		tab_active = {
			"index",
			{ "parent", padding = 0 },
			"/",
			{ "cwd", padding = { left = 0, right = 1 } },
			{ "zoomed", padding = 0 },
		},
		tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
		tabline_x = {},
		tabline_y = {},
		tabline_z = { "domain" },
	},
})
tabline.apply_to_config(config)

return config
