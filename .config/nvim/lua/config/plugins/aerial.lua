local M = {
  "stevearc/aerial.nvim",
  cmd = "AerialToggle",
}

function M.init() vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<cr>") end

M.config = {
  backends = {
    "lsp",
    "treesitter",
    "markdown",
    "man",
  },
  layout = {
    width = nil,
    min_width = 20,
    max_width = { 80, 0.5 },
    win_opts = {
      winblend = 30,
    },
    default_direction = "float",
    placement = "edge",
  },
  highlight_mode = "last",
  manage_folds = "auto",
  close_on_select = true,
  show_guides = true,
  float = {
    border = "rounded",
    relative = "win",
    height = nil,
    min_height = { 8, 0.1 },
    max_height = 0.9,
    override = function(conf, source_winid)
      conf.anchor = "NE"
      conf.col = vim.fn.winwidth(source_winid)
      conf.row = 0
      return conf
    end,
  },
}

return M
