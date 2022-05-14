require('toggleterm').setup {
  open_mapping = [[<c-\>]],
  direction = 'float',
}

local Terminal = require('toggleterm.terminal').Terminal
local tig      = Terminal:new({ cmd = 'tig', hidden = true })

function _tig_toggle()
  tig:toggle()
end

vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>lua _tig_toggle()<CR>', { noremap = true, silent = true })
