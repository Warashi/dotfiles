-- lua_source {{{
local vimx = require('artemis')
vimx.fn.lspoints.load_extensions({ 'config', 'nvim_diagnostics', 'format' })

vimx.create_autocmd('User', {
  pattern = 'LspointsAttach:*',
  callback = function()
    local start = vimx.fn.ddu.start
    local opts = { buffer = true }

    vimx.keymap.set('n', '<space>f', function()
      vimx.fn.denops.request('lspoints', 'executeCommand', { 'format', 'execute', vimx.fn.bufnr() })
    end, opts)

    vimx.keymap.set("n", "gd", function() start({ name = "lsp-definition" }) end, opts)
    vimx.keymap.set("n", "gr", function() start({ name = "lsp-references" }) end, opts)
    vimx.keymap.set("n", "<space>q", function() start({ name = "lsp-diagnostic" }) end, opts)
    vimx.keymap.set({ "n", "v" }, "<space>ca", function() start({ name = "lsp-codeAction" }) end, opts)
  end,
})
vimx.create_autocmd('FileType', {
  pattern = { 'lua' },
  callback = function()
    vimx.fn.lspoints.attach('luals')
  end,
})
vimx.create_autocmd('FileType', {
  pattern = { 'typescript', 'typescriptreact' },
  callback = function()
    vimx.fn.lspoints.attach('denols')
  end,
})
vimx.create_autocmd('FileType', {
  pattern = { 'go' },
  callback = function()
    vimx.fn.lspoints.attach('gopls')
  end,
})
vimx.create_autocmd('FileType', {
  pattern = { 'nix' },
  callback = function()
    vimx.fn.lspoints.attach('nills')
  end,
})
vimx.create_autocmd('FileType', {
  pattern = { 'vim' },
  callback = function()
    vimx.fn.lspoints.attach('vimls')
  end,
})
-- }}}
