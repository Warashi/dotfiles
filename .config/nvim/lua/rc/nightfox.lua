require('nightfox').init {
  transparent = true
}
vim.cmd([[ colorscheme nordfox ]])


require('lualine').setup {
  options = {
    theme = 'nordfox'
  }
}
