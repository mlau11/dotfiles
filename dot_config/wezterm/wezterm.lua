local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.term = "xterm-256color"
config.automatically_reload_config = true
config.default_cursor_style = "BlinkingBlock"
config.animation_fps = 120

config.font = wezterm.font("0xProto Nerd Font")
config.color_scheme = "duckbones"
config.font_size = 14

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.window_padding = {
	left = 20,
	right = 20,
	top = 20,
	bottom = 20,
}

if wezterm.target_triple:find("windows") then
	config.default_prog = { "powershell.exe", "-NoLogo" }
end

return config
