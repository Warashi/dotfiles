require('bufferline').setup {
  options = {
    diagnostics = 'nvim_lsp',
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_buffer_default_icon = true,
    show_close_icon = false,
    show_tab_indicators = false,
    always_show_bufferline = true,
  },
}
vim.keymap.set('n', ']b', '<cmd>BufferLineCycleNext<cr>', { silent = true })
vim.keymap.set('n', '[b', '<cmd>BufferLineCyclePrev<cr>', { silent = true })
