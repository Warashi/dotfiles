require('toggleterm').setup {
  open_mapping = [[<c-\>]],
  direction = 'float',
  float_opts = {
    border = 'rounded',
  },
}

local Terminal = require('toggleterm.terminal').Terminal
local tig      = Terminal:new({ cmd = 'tig', hidden = true })

function _tig_toggle()
  tig:toggle()
end

vim.keymap.set('n', '<leader>g', '<cmd>lua _tig_toggle()<CR>', { silent = true })
