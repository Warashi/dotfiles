local function startfn(config)
  local sources = {}
  local tableconfig = {}

  for k, v in pairs(config) do
    if type(k) == "number" then
      sources[k] = type(v) == "string" and { name = v } or v
    else
      tableconfig[k] = v
    end
  end
  tableconfig.sources = sources
  return function() vim.call("ddu#start", tableconfig) end
end

vim.keymap.set("n", "<space>ff", startfn({ "file_rec", params = {} }))
vim.keymap.set("n", "<space>fb", startfn({ "buffer" }))
vim.keymap.set("n", "<space>fr", startfn({ "register" }))
vim.keymap.set("n", "<space>fm", startfn({ "mr", kind = "mru" }))

vim.fn["ddu#custom#patch_global"]({
  ui = "ff",
  uiParams = {
    ff = {
      split = "floating",
      prompt = "> ",
    },
  },
  sourceOptions = {
    ["_"] = {
      matchers = { "matcher_substring" },
    },
    rg = {
      args = { "--column", "--no-heading", "--color", "never" },
    },
  },
  kindOptions = {
    file = { defaultAction = "open" },
    word = { defaultAction = "append" },
  },
  sourceParams = {
    rg = {
      args = { "--column", "--no-heading", "--color", "--hidden" },
    },
    file_external = {
      cmd = { "fd", "-H", "-t", "f", "." },
    },
  },
})

local function nmap_action(lhs, action)
  local opt = { buffer = true, silent = true }
  vim.keymap.set("n", lhs, function() vim.call("ddu#ui#ff#do_action", action) end, opt)
end

local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  pattern = "ddu-ff",
  callback = function()
    nmap_action("<CR>", "itemAction")
    nmap_action("<Space>", "toggleSelectItem")
    nmap_action("i", "openFilterWindow")
    nmap_action("q", "quit")
    nmap_action("<Esc>", "quit")
  end,
})

autocmd("FileType", {
  pattern = "ddu-ff-filter",
  callback = function()
    local opt = { buffer = true, silent = true }
    vim.keymap.set("i", "<CR>", "<Esc><Cmd>close<CR>", opt)
    vim.keymap.set("n", "<CR>", "<Cmd>close<CR>", opt)
    vim.keymap.set("n", "q", "<Cmd>close<CR>", opt)
    vim.keymap.set("n", "<Esc>", "<Cmd>close<CR>", opt)
  end,
})
