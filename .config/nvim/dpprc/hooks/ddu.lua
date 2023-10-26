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
      local action = vim.fn["ddu#ui#ff#do_action"]
      local opts = { buffer = true }
      vim.keymap.set("n", "<CR>", function() action("itemAction") end, opts)
      vim.keymap.set("n", "<Space>", function() action("toggleSelectItem") end, opts)
      vim.keymap.set("n", "i", function() action("openFilterWindow") end, opts)
      vim.keymap.set("n", "q", function() action("quit") end, opts)
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "ddu-ff-filter",
    callback = function()
      local opts = { buffer = true }
      vim.keymap.set("i", "<CR>", "<Esc><Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>", opts)
      vim.keymap.set("n", "<CR>", "<Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>", opts)
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

  vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function(ev)
      local opts = { buffer = ev.buf }
      vim.keymap.set("n", "gd", function() start({ name = "lsp-definition" }) end, opts)
      vim.keymap.set("n", "gr", function() start({ name = "lsp-references" }) end, opts)
      vim.keymap.set("n", "<space>q", function() start({ name = "lsp-diagnostic" }) end, opts)
      vim.keymap.set({ "n", "v" }, "<space>ca", function() start({ name = "lsp-codeAction" }) end, opts)
    end,
  })
end

set_keymaps()
-- }}}

-- lua_source {{{
vim.fn["ddu#custom#load_config"](vim.env.DPP_CONFIG_BASE .. "/hooks/ddu.ts")
-- }}}
