-- lua_source {{{
local vimx = require('artemis')
vimx.create_autocmd('User', {
  pattern = 'DenopsPluginPost:lspoints',
  callback = function()
    -- 応急処置
    vimx.fn.lspoints.denops.request('loadExtensions', { { 'config', 'nvim_diagnostics', 'format' } })
    -- vimx.fn.lspoints.load_extensions({ 'config', 'nvim_diagnostics', 'format' })
  end,
})
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
    require('config.lspoints').server.gopls.attach()
  end,
})
vimx.create_autocmd('FileType', {
  pattern = { 'nix' },
  callback = function()
    require('config.lspoints').server.nills.attach()
  end,
})
-- }}}
