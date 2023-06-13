-- lua_source {{{
local palette = require("catppuccin.palettes").get_palette()
local colors = {
  bg = palette.base,
  fg = palette.text,
  red = palette.red,
  green = palette.green,
  yellow = palette.yellow,
  blue = palette.blue,
  magenta = palette.peach,
  cyan = palette.teal,
  dark = palette.mantle,
}
require("heirline").setup({
  statusline = require("config.heirline.statusline"),
  winbar = require("config.heirline.winbar"),
  opts = {
    colors = colors,
  },
})
-- }}}
