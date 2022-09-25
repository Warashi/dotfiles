require("toggleterm").setup({
  open_mapping = [[<c-\>]],
  direction = "float",
  float_opts = {
    border = "rounded",
  },
})

local terms = require("toggleterm.terminal")
local Terminal = terms.Terminal
local tig = Terminal:new({
  cmd = "tig",
  hidden = true,
  on_open = function(term)
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = term.bufnr, silent = true })
    vim.keymap.set("n", [[<c-\>]], "<cmd>close<cr>", { buffer = term.bufnr, silent = true })
    vim.keymap.set("t", [[<c-\>]], "<cmd>close<cr>", { buffer = term.bufnr, silent = true })
  end,
})

function TIG_toggle() tig:toggle() end

vim.keymap.set("n", "<leader>g", TIG_toggle, { silent = true })

local function smart_close()
  if tig:is_open() then tig:close() end
  local terminals = terms.get_all()
  -- count backwards from the end of the list
  for i = #terminals, 1, -1 do
    local term = terminals[i]
    if term then term:close() end
  end
end

vim.api.nvim_create_user_command("ToggleTermClose", smart_close, {})
