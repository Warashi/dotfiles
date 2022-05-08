require('nightfox').setup {
  options = {
    transparent = false,
    terminal_colors = true,
    dim_inactive = true,
  },
}
vim.cmd([[ colorscheme nordfox ]])

require('lualine').setup {
  options = {
    theme = 'nordfox',
  },
}
