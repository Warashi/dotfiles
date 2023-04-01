local wezterm = require("wezterm")

local M = {
  hide_tab_bar_if_only_one_tab = true,

  color_scheme = "Catppuccin Mocha",

  line_height = 1.2,
  font_size = 18.0,
  font = wezterm.font_with_fallback({
    { family = "UDEV Gothic NFLG" },
    { family = "UDEV Gothic NFLG", assume_emoji_presentation = true },
  }),
}

return M
