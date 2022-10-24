local fn = vim.fn

local function commandline_post(maps)
  for lhs, _ in pairs(maps) do
    pcall(vim.keymap.del, "c", lhs)
  end
  if vim.b.prev_buffer_config ~= nil then
    fn["ddc#custom#set_buffer"](vim.b.prev_buffer_config)
    vim.b.prev_buffer_config = nil
  else
    fn["ddc#custom#set_buffer"]({})
  end
end

local function commandline_pre()
  local maps = {
    ["<C-n>"] = function() fn["pum#map#insert_relative"](1) end,
    ["<C-p>"] = function() fn["pum#map#insert_relative"](-1) end,
  }
  for lhs, rhs in pairs(maps) do
    vim.keymap.set("c", lhs, rhs)
  end
  if vim.b.prev_buffer_config == nil then
    -- Overwrite sources
    vim.b.prev_buffer_config = fn["ddc#custom#get_buffer"]()
  end
  fn["ddc#custom#patch_buffer"]("cmdlineSources", { "cmdline", "cmdline-history", "file", "around" })
  vim.api.nvim_create_autocmd("User", {
    pattern = "DDCCmdLineLeave",
    once = true,
    callback = function() pcall(commandline_post, maps) end,
  })
  vim.api.nvim_create_autocmd("InsertEnter", {
    once = true,
    buffer = 0,
    callback = function() pcall(commandline_post, maps) end,
  })

  -- Enable command line completion
  fn["ddc#enable_cmdline_completion"]()
end

vim.keymap.set("n", ":", function()
  commandline_pre()
  return ":"
end, { expr = true })

local patch_global = vim.fn["ddc#custom#patch_global"]
patch_global("autoCompleteEvents", { "InsertEnter", "TextChangedI", "TextChangedP", "CmdlineEnter", "CmdlineChanged" })
patch_global("cmdlineSources", { "cmdline", "cmdline-history", "file", "around" })
patch_global("completionMenu", "pum.vim")
patch_global("sources", { "nvim-lsp", "around", "file" })
patch_global("sourceOptions", {
  around = { mark = "A", maxSize = 500 },
  ["nvim-lsp"] = { mark = "L" },
  file = {
    mark = "F",
    isVolatile = true,
    forceCompletionPattern = [[\S/\S*]],
  },
  cmdline = { mark = "CMD" },
  ["cmdline-history"] = { mark = "CMD" },
  ["_"] = {
    matchers = { "matcher_fuzzy" },
    sorters = { "sorter_fuzzy" },
    converters = { "converter_fuzzy" },
  },
})
vim.fn["ddc#enable"]()
