local M = {}

function M.on_attach(client, bufnr)
  -- omnifunc, tagfunc
  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
  vim.bo.tagfunc = "v:lua.vim.lsp.tagfunc"

  -- keymaps
  local opts = { silent = true, buffer = true }
  vim.keymap.set("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  vim.keymap.set("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.keymap.set("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  vim.keymap.set("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  vim.keymap.set("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  vim.keymap.set("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.keymap.set("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.keymap.set("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.keymap.set("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

  -- format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      buffer = bufnr,
      callback = function() vim.lsp.buf.format() end,
    })
  end
end

function M.null_ls()
  local null_ls = require("null-ls")
  local sources = {
    --- nix ---
    null_ls.builtins.diagnostics.deadnix,
    null_ls.builtins.diagnostics.statix,
    null_ls.builtins.formatting.alejandra,

    --- lua ---
    null_ls.builtins.diagnostics.selene.with({
      cwd = function() return require("null-ls.utils").root_pattern("selene.toml")(vim.api.nvim_buf_get_name(0)) end,
    }),
    null_ls.builtins.formatting.stylua.with({
      cwd = function() return require("null-ls.utils").root_pattern("stylua.toml")(vim.api.nvim_buf_get_name(0)) end,
    }),

    --- shell ---
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.zsh,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.shellharden,

    --- other ---
    null_ls.builtins.diagnostics.todo_comments,
  }

  null_ls.setup({
    on_attach = M.on_attach,
    sources = sources,
  })
end

-- Set up lspconfig.
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

function M.hover_handler_config()
  vim.lsp.handlers["textDocument/hover"] = function(_, results, ctx, config)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    vim.lsp.handlers.hover(
      _,
      results,
      ctx,
      vim.tbl_deep_extend("force", config or {}, {
        border = "single",
        title = client.name,
      })
    )
  end
end

function M.mason()
  require("mason").setup()
  require("mason-lspconfig").setup()
  require("mason-lspconfig").setup_handlers({
    function(server_name)
      require("lspconfig")[server_name].setup({
        on_attach = M.on_attach,
        capabilities = M.capabilities,
      })
    end,
    jdtls = function()
      require("lspconfig")["jdtls"].setup({
        on_attach = M.on_attach,
        capabilities = M.capabilities,
        root_dir = function(filename, _)
          return vim.fs.dirname(vim.fs.find(".git", { path = filename, upward = true, type = "directory" })[1])
        end,
      })
    end,
  })
end

function M.goimports()
  local function organize_imports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function() organize_imports(1000) end,
  })
end

return M
