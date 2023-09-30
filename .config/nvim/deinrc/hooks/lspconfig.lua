-- lua_add {{{
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client == nil then return end

    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = bufnr }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format({ async = false }) end, opts)
    vim.keymap.set("n", "<space>i", function() vim.lsp.inlay_hint(bufnr, nil) end, opts)
  end,
})
-- }}}

-- lua_source {{{
require("ddc_nvim_lsp_setup").setup({})
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

for _, server in ipairs({
  "bufls",
  "hls",
  "nil_ls",
  "rust_analyzer",
  "taplo",
  "terraformls",
  "yamlls",
  "zls",
}) do
  lspconfig[server].setup({})
end

lspconfig["lua_ls"].setup({
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      format = {
        enable = false,
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      hint = {
        enable = true,
        setType = true,
      },
    },
  },
})

lspconfig["denols"].setup({
  root_dir = util.root_pattern("deno.json", "deno.jsonc"),
  init_options = {
    lint = true,
    unstable = true,
    suggest = {
      imports = {
        hosts = {
          ["https://deno.land"] = true,
          ["https://cdn.nest.land"] = true,
          ["https://crux.land"] = true,
        },
      },
    },
    inlayHints = {
      parameterNames = {
        enabled = "all",
      },
      parameterTypes = {
        enabled = true,
      },
      variableTypes = {
        enabled = true,
      },
      propertyDeclarationTypes = {
        enabled = true,
      },
      functionLikeReturnTypes = {
        enabled = true,
      },
      enumMemberValues = {
        enabled = true,
      },
    },
  },
})

lspconfig["tsserver"].setup({
  root_dir = util.root_pattern("package.json"),
  single_file_support = false,
  typescript = {
    inlayHints = {
      parameterNames = {
        enabled = "all",
      },
      parameterTypes = {
        enabled = true,
      },
      variableTypes = {
        enabled = true,
      },
      propertyDeclarationTypes = {
        enabled = true,
      },
      functionLikeReturnTypes = {
        enabled = true,
      },
      enumMemberValues = {
        enabled = true,
      },
    },
  },
})

lspconfig["gopls"].setup({
  settings = {
    gopls = {
      buildFlags = { "-tags=wireinject" },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})
-- }}}
