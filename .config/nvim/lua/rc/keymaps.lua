vim.g.mapleader = ","

local opts = { silent = true }

-- util --
vim.keymap.set("n", "<leader><leader>", ":source $MYVIMRC<CR>", { silent = true })
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { silent = true })

-- bufdelete --
vim.keymap.set("", "<leader>d", "<cmd>Bdelete<cr>", opts)

-- telescope --
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope git_files<cr>", opts)
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
vim.keymap.set("n", "<leader>cd", "<cmd>Telescope zoxide list<cr>", opts)

-- trouble --
vim.keymap.set("n", "<leader>t", "<cmd>TroubleToggle<cr>", opts)
