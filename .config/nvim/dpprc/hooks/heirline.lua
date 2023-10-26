--- lua_source {{{
require("heirline").setup({
  statusline = require("config.heirline.statusline"),
  winbar = require("config.heirline.winbar"),
  opts = {
    colors = require("config.heirline.colors"),
    disable_winbar_cb = function(args)
      local conditions = require("heirline.conditions")
      return conditions.buffer_matches({
        buftype = { "nofile", "prompt", "help", "quickfix" },
        filetype = { "^git.*", "fugitive", "Trouble", "dashboard", "ddu-ff" },
      }, args.buf)
    end,
  },
})
-- }}}
