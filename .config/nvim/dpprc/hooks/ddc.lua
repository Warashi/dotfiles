-- lua_source {{{
vim.fn["ddc#custom#load_config"](vim.env.DPP_CONFIG_BASE .. "/hooks/ddc.ts")

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

local opts = { silent = true, expr = true, replace_keycodes = false }
vim.keymap.set({ "i", "c" }, "<C-n>", function() return complete_or_select(1) end, opts)
vim.keymap.set({ "i", "c" }, "<C-p>", function() return complete_or_select(-1) end, opts)
vim.keymap.set({ "i", "c" }, "<C-y>", vim.fn["pum#map#confirm"])
vim.keymap.set({ "i", "c" }, "<C-o>", vim.fn["pum#map#confirm_word"])
vim.keymap.set({ "i", "c" }, "<C-e>", vim.fn["pum#map#cancel"])

-- enable
vim.fn["ddc#enable"]()
-- }}}
