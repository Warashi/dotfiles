-- lua_source {{{
vim.fn["ddc#custom#load_config"](vim.env.DEIN_CONFIG_BASE .. "hooks/ddc.ts")

-- pum
local function complete_or_select(rel)
  if vim.fn["pum#visible"]() then
    vim.fn["pum#map#select_relative"](rel)
  else
    return vim.fn["ddc#map#manual_complete"]()
  end
end
vim.fn["pum#set_option"]("border", "single")
vim.keymap.set(
  "i",
  "<C-n>",
  function() return complete_or_select(1) end,
  { silent = true, expr = true, replace_keycodes = false }
)
vim.keymap.set(
  "i",
  "<C-p>",
  function() return complete_or_select(-1) end,
  { silent = true, expr = true, replace_keycodes = false }
)
vim.keymap.set("i", "<C-y>", function() vim.fn["pum#map#confirm"]() end)
vim.keymap.set("i", "<C-e>", function() vim.fn["pum#map#cancel"]() end)

-- cmdline
local function commandline_post(maps)
  for lhs, _ in pairs(maps) do
    pcall(vim.keymap.del, "c", lhs)
  end
  if vim.b.prev_buffer_config ~= nil then
    vim.fn["ddc#custom#set_buffer"](vim.b.prev_buffer_config)
    vim.b.prev_buffer_config = nil
  else
    vim.fn["ddc#custom#set_buffer"]({})
  end
end

local function commandline_pre()
  local maps = {
    ["<C-n>"] = function() vim.fn["pum#map#insert_relative"](1) end,
    ["<C-p>"] = function() vim.fn["pum#map#insert_relative"](-1) end,
  }
  for lhs, rhs in pairs(maps) do
    vim.keymap.set("c", lhs, rhs)
  end
  if vim.b.prev_buffer_config == nil then
    -- Overwrite sources
    vim.b.prev_buffer_config = vim.fn["ddc#custom#get_buffer"]()
  end
  vim.fn["ddc#custom#patch_buffer"]("cmdlineSources", { "cmdline", "cmdline-history", "file", "around" })
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
  vim.fn["ddc#enable_cmdline_completion"]()
end

vim.keymap.set("n", ":", function()
  commandline_pre()
  return ":"
end, { expr = true, remap = true })

-- enable
vim.fn["ddc#enable"]()
-- }}}
