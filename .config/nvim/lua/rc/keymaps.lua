vim.g.mapleader = ","

local opts = { silent = true }

-- util --
vim.keymap.set("n", "<leader><leader>", ":source $MYVIMRC<CR>", { silent = true })
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { silent = true })

-- bufdelete --
vim.keymap.set("", "<leader>d", "<cmd>Bdelete<cr>", opts)

-- trouble --
vim.keymap.set("n", "<leader>t", "<cmd>TroubleToggle<cr>", opts)
