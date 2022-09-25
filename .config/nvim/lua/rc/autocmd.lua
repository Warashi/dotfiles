local autocmd = vim.api.nvim_create_autocmd
autocmd("BufEnter", {
  pattern = "*.go",
  callback = function() require("rc.goimports") end,
})
