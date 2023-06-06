-- lua_source {{{
vim.fn["ddc#custom#load_config"](vim.env.DEIN_CONFIG_BASE .. "hooks/ddc.ts")

-- pum
vim.fn["pum#set_option"]("border", "single")

-- keybinds
local function complete_or_select(rel)
  if vim.fn["pum#visible"]() then
    vim.fn["pum#map#select_relative"](rel)
  else
    return vim.fn["ddc#map#manual_complete"]()
  end
end
vim.keymap.set(
  { "i", "c" },
  "<C-n>",
  function() return complete_or_select(1) end,
  { silent = true, expr = true, replace_keycodes = false }
)
vim.keymap.set(
  { "i", "c" },
  "<C-p>",
  function() return complete_or_select(-1) end,
  { silent = true, expr = true, replace_keycodes = false }
)
vim.keymap.set({ "i", "c" }, "<C-y>", function() vim.fn["pum#map#confirm"]() end)
vim.keymap.set({ "i", "c" }, "<C-o>", function() vim.fn["pum#map#confirm_word"]() end)
vim.keymap.set({ "i", "c" }, "<C-e>", function() vim.fn["pum#map#cancel"]() end)

-- enable
vim.fn["ddc#enable"]()
-- }}}
