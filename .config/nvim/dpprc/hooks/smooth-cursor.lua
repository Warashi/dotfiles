-- lua_source {{{
require("smoothcursor").setup({
  disable_float_win = true,
  priority = 100,
  autostart = true,
  threshold = 1,
  speed = 18,
  type = "exp",
  intervals = 22,
  fancy = {
    enable = true,
    head = { cursor = "", texthl = "SmoothCursor" },
    body = {
      { cursor = "●", texthl = "SmoothCursorBody" },
      { cursor = "●", texthl = "SmoothCursorBody" },
      { cursor = "•", texthl = "SmoothCursorBody" },
      { cursor = "•", texthl = "SmoothCursorBody" },
      { cursor = "∙", texthl = "SmoothCursorBody" },
      { cursor = "∙", texthl = "SmoothCursorBody" },
    },
  },
})

-- normal mode as default
vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#8aa872" })
vim.api.nvim_set_hl(0, "SmoothCursorBody", { fg = "#8aa872" })

vim.api.nvim_create_autocmd("ModeChanged", {
  callback = function()
    local current_mode = vim.fn.mode()
    if current_mode == "n" then
      vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#8aa872" })
      vim.api.nvim_set_hl(0, "SmoothCursorBody", { fg = "#8aa872" })
      vim.fn.sign_define("smoothcursor", { text = "" })
    elseif current_mode == "v" then
      vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#bf616a" })
      vim.api.nvim_set_hl(0, "SmoothCursorBody", { fg = "#bf616a" })
      vim.fn.sign_define("smoothcursor", { text = "" })
    elseif current_mode == "V" then
      vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#bf616a" })
      vim.api.nvim_set_hl(0, "SmoothCursorBody", { fg = "#bf616a" })
      vim.fn.sign_define("smoothcursor", { text = "" })
    elseif current_mode == "" then
      vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#bf616a" })
      vim.api.nvim_set_hl(0, "SmoothCursorBody", { fg = "#bf616a" })
      vim.fn.sign_define("smoothcursor", { text = "" })
    elseif current_mode == "i" then
      vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#668aab" })
      vim.api.nvim_set_hl(0, "SmoothCursorBoby", { fg = "#668aab" })
      vim.fn.sign_define("smoothcursor", { text = "" })
    end
  end,
})
-- }}}
