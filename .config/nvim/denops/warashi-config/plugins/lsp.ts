import { Plugin } from "./types.ts";

export const lsp: Plugin[] = [
  {
    org: "folke",
    repo: "neoconf.nvim",
  },
  {
    org: "folke",
    repo: "neodev.nvim",
  },
  {
    org: "neovim",
    repo: "nvim-lspconfig",
    lua_pre: `
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
        end,
      })
    `,
    lua_post: `
      -- 依存関係と実行順の都合でここに記載する
      require("neodev").setup({})
      require("neoconf").setup({})

      local lspconfig = require("lspconfig")
      lspconfig.gopls.setup({
        settings = {
          gopls = {
            buildFlags = { "-tags=wireinject" },
          },
        },
      })
      lspconfig.lua_ls.setup({})
      lspconfig.terraformls.setup({})
      lspconfig.zls.setup({})
      lspconfig.denols.setup({
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
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
        },
      })
      lspconfig.tsserver.setup({
        root_dir = lspconfig.util.root_pattern("package.json"),
        single_file_support = false,
      })
    `,
  },
  {
    org: "j-hui",
    repo: "fidget.nvim",
    lua_post: `require("fidget").setup({})`,
  },
  {
    org: "jose-elias-alvarez",
    repo: "null-ls.nvim",
    lua_post: `
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
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
        },
      })
    `,
  },
  {
    url: "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    dst: "git.sr.ht/~whynothugo/lsp_lines.nvim",
    lua_post: `
      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = { only_current_line = true },
      })
      require("lsp_lines").setup()
    `,
  },
];
