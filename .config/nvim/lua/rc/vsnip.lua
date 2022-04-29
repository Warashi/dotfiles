-- キーコードをluaで扱うのが面倒なのでvim scriptでやる……

-- " Expand
vim.cmd([[ imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>' ]])
vim.cmd([[ smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>' ]])

-- " Expand or jump
vim.cmd([[ imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>' ]])
vim.cmd([[ smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>' ]])

-- " Jump forward or backward
vim.cmd([[ imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>' ]])
vim.cmd([[ smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>' ]])
vim.cmd([[ imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>' ]])
vim.cmd([[ smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>' ]])

-- " Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
-- " See https://github.com/hrsh7th/vim-vsnip/pull/50
vim.cmd([[ nmap        s   <Plug>(vsnip-select-text) ]])
vim.cmd([[ xmap        s   <Plug>(vsnip-select-text) ]])
vim.cmd([[ nmap        S   <Plug>(vsnip-cut-text) ]])
vim.cmd([[ xmap        S   <Plug>(vsnip-cut-text) ]])

