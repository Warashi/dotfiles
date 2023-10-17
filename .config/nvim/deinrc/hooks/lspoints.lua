-- lua_source {{{
local vimx = require('artemis')
vimx.fn.lspoints.load_extensions({
  'config',
  'nvim_diagnostics',
  'format',
  'hover',
})

vimx.create_autocmd('User', {
  pattern = 'LspointsAttach:*',
  callback = function()
    local start = vimx.fn.ddu.start
    local executeCommand = function(command) vimx.fn.denops.request('lspoints', 'executeCommand', command) end

    local opts = { buffer = true }
    vimx.keymap.set('n', '<space>f', function() executeCommand({ 'format', 'execute', vimx.fn.bufnr() }) end, opts)
    vimx.keymap.set('n', 'K', function() executeCommand({ 'hover', 'execute' }) end, opts)
    vimx.keymap.set("n", "gd", function() start({ name = "lsp-definition" }) end, opts)
    vimx.keymap.set("n", "gr", function() start({ name = "lsp-references" }) end, opts)
    vimx.keymap.set("n", "<space>q", function() start({ name = "lsp-diagnostic" }) end, opts)
    vimx.keymap.set({ "n", "v" }, "<space>ca", function() start({ name = "lsp-codeAction" }) end, opts)
  end,
})
-- }}}
