-- lua_source {{{
local function skkeleton_init()
  vim.fn["skkeleton#config"]({
    useSkkServer = true,
    globalDictionaries = { "/dev/null" },
  })
  vim.fn["skkeleton#register_keymap"]("input", ";", "henkanPoint")
  vim.fn["skkeleton#register_kanatable"]("rom", {
    ["~"] = { "～" },
  })
end
vim.keymap.set("i", "<C-j>", "<Plug>(skkeleton-enable)", { silent = true })
vim.api.nvim_create_autocmd("User", { pattern = "skkeleton-initialize-pre", callback = skkeleton_init })
-- }}}
