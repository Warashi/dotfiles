-- lua_add {{{
local function skkeleton_init()
  vim.fn["skkeleton#config"]({
    globalDictionaries = { "/dev/null" },
    completionRankFile = "~/.config/skkeleton/rank.json",
    registerConvertResult = true,
    useSkkServer = true,
  })
  vim.fn["skkeleton#register_keymap"]("input", ";", "henkanPoint")
end
vim.keymap.set({ "i", "c", "t" }, "<C-j>", "<Plug>(skkeleton-enable)", { silent = true })
vim.api.nvim_create_autocmd("User", { pattern = "skkeleton-initialize-pre", callback = skkeleton_init })
-- }}}
