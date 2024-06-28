-- lua_add {{{
local function set_keymaps()
  local start = vim.fn["ddu#start"]

  vim.keymap.set("n", "<leader>ds", function() start({ sources = { { name = "source" } } }) end)
  vim.keymap.set("n", "<leader>dh", function() start({ sources = { { name = "help" } } }) end)
  vim.keymap.set("n", "<leader>dw", function() start({ sources = { { name = "window" } } }) end)
  vim.keymap.set("n", "<leader>df", function() start({ name = "git-ls-files" }) end)
  vim.keymap.set("n", "<leader>dq", function() start({ name = "ghq" }) end)
  vim.keymap.set("i", "<C-x><C-l>", function() start({ sync = true, sources = { { name = "copilot" } } }) end)
  vim.keymap.set(
    "i",
    "<C-x><C-e>",
    function()
      start({
        sources = { { name = "emoji", options = { defaultAction = "append" } } },
        uiParams = { ff = { replaceCol = vim.fn.col(".") } },
      })
    end
  )

  local group = vim.api.nvim_create_augroup("my-custom-ddu-augroup", {})

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "ddu-ff",
    callback = function()
      local action = vim.fn["ddu#ui#do_action"]
      local opts = { buffer = true }
      vim.keymap.set("n", "<CR>", function() action("itemAction") end, opts)
      vim.keymap.set("n", "<Space>", function() action("toggleSelectItem") end, opts)
      vim.keymap.set("n", "i", function() action("openFilterWindow") end, opts)
      vim.keymap.set("n", "q", function() action("quit") end, opts)
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "ddu-filer",
    callback = function()
      local action = vim.fn["ddu#ui#filer#do_action"]
      local opts = { buffer = true }
      vim.keymap.set("n", "<CR>", function() action("itemAction") end, opts)
      vim.keymap.set("n", "<Space>", function() action("toggleSelectItem") end, opts)
      vim.keymap.set("n", "o", function() action("expandItem", { mode = "toggle" }) end, opts)
      vim.keymap.set("n", "q", function() action("quit") end, opts)
    end,
  })
end

set_keymaps()
-- }}}

-- lua_source {{{
vim.fn["ddu#set_static_import_path"]()
vim.fn["ddu#custom#load_config"](vim.env.DPP_CONFIG_BASE .. "/hooks/ddu.ts")
-- }}}
