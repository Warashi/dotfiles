local wezterm = require("wezterm")
return {
	font = wezterm.font("UDEV Gothic NFLG"),
	font_size = 13,
	line_height = 1.2,
	color_scheme = "nord",
	enable_tab_bar = false,
	enable_scroll_bar = false,
	scrollback_lines = 0,
	window_frame = {
		font = wezterm.font({ family = "UDEV Gothic NFLG", weight = "Bold" }),
		font_size = 13,
	},
}
