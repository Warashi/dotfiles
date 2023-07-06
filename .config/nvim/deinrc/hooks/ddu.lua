-- lua_add {{{
local function start(opts)
  local width = math.floor(vim.o.columns * 0.8)
  local previewWidth = math.floor(width * 0.5) - 1
  local height = math.floor(vim.o.lines * 0.8)
  local previewHeight = height - 2
  local row = math.floor((vim.o.lines - height) / 2)
  local previewRow = row + 1
  local col = math.floor(vim.o.columns * 0.1)
  local halfWidth = math.floor(vim.o.columns * 0.5)
  local previewCol = halfWidth - 1
  local default = {
    uiParams = {
      ff = {
        winWidth = width,
        winHeight = height,
        winRow = row,
        winCol = col,
        previewWidth = previewWidth,
        previewHeight = previewHeight,
        previewRow = previewRow,
        previewCol = previewCol,
      },
    },
  }

  local config = vim.tbl_deep_extend("keep", default, opts)
  vim.fn["ddu#start"](config)
end

local function set_keymaps()
  vim.keymap.set("n", "<leader>d", function() start({ name = "source" }) end)
  vim.keymap.set("i", "<C-x><C-l>", function() start({ name = "copilot" }) end)
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

  vim.api.nvim_create_autocmd("FileType", {
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
    pattern = "ddu-ff-filter",
    callback = function()
      local opts = { buffer = true }
      vim.keymap.set("i", "<CR>", "<Esc><Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>", opts)
      vim.keymap.set("n", "<CR>", "<Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>", opts)
    end,
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspAttach_ddu", {}),
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
vim.fn["ddu#custom#load_config"](vim.env.DEIN_CONFIG_BASE .. "hooks/ddu.ts")
