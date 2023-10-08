local vimx = require('artemis')

local M = {}

local function attach(name, options)
  return function()
    vimx.fn.lspoints.attach(name, options)
  end
end

M.config = {}

M.server = {}

M.server.denols = {
  attach = attach('denols', {
    cmd = { 'deno', 'lsp' },
    initializationOptions = {
      enable = true,
      unstable = true,
      suggest = {
        autoImports = false,
      },
    },
  }),
}

M.server.luals = {
  attach = attach('luals', {
    cmd = { 'lua-language-server' },
  }),
}

M.server.gopls = {
  attach = attach('gopls', {
    cmd = { 'gopls' },
    initializationOptions = {
      buildFlags = { "-tags=wireinject" },
    },
  }),
}

M.server.nills = {
  attach = attach('nills', {
    cmd = { 'nil' },
  }),
}

return M