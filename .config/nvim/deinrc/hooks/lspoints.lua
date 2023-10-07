-- lua_source {{{
local vimx = require('artemis')
vimx.create_autocmd('User', {
  pattern = 'DenopsPluginPost:lspoints',
  callback = function()
    vimx.fn.lspoints.load_extensions { 'nvim_diagnostics', 'format' }
    vimx.fn.lspoints.settings.patch {
      tracePath = '/tmp/lspoints',
    }
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
    require('config.lspoints').server.luals.attach()
  end,
})
vimx.create_autocmd('FileType', {
  pattern = { 'typescript', 'typescriptreact' },
  callback = function()
    require('config.lspoints').server.denols.attach()
  end,
})
vimx.create_autocmd('FileType', {
  pattern = { 'go' },
  callback = function()
    require('config.lspoints').server.gopls.attach()
  end,
})
-- }}}
