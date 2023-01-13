local M = {
  "vim-skk/skkeleton",
  lazy = false,
}

local function skkeleton_init()
  vim.fn["skkeleton#config"]({ useSkkServer = true })
  vim.fn["skkeleton#register_keymap"]("input", ";", "henkanPoint")
  vim.fn["skkeleton#register_kanatable"]("rom", {
    ["~"] = { "～" },
  })
end

function M.config()
  vim.keymap.set("i", "<C-j>", "<Plug>(skkeleton-enable)", { silent = true })
  vim.api.nvim_create_autocmd("User", { pattern = "skkeleton-initialize-pre", callback = skkeleton_init })
end

return M
