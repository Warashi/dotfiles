type Plugin = {
  org: string;
  repo: string;
  lua_pre?: string;
  lua_post?: string;
};

export const plugins: Plugin[] = [
  { org: "vim-denops", repo: "denops.vim" },
  { org: "lambdalisue", repo: "kensaku.vim" },
  { org: "MunifTanjim", repo: "nui.nvim" },
  { org: "nvim-lua", repo: "plenary.nvim" },
  {
    org: "vim-skk",
    repo: "skkeleton",
    lua_pre: `
      local function skkeleton_init()
        vim.fn["skkeleton#config"]({
          useSkkServer = true,
          globalDictionaries = { "/dev/null" },
        })
        vim.fn["skkeleton#register_keymap"]("input", ";", "henkanPoint")
        vim.fn["skkeleton#register_kanatable"]("rom", {
          ["~"] = { "～" },
        })
      end
      vim.keymap.set("i", "<C-j>", "<Plug>(skkeleton-enable)", { silent = true })
      vim.api.nvim_create_autocmd("User", { pattern = "skkeleton-initialize-pre", callback = skkeleton_init })
    `,
  },
  {
    org: "matsui54",
    repo: "denops-popup-preview.vim",
    // lua: `vim.fn["popup_preview#enable"]()`,
  },
  {
    org: "matsui54",
    repo: "denops-signature_help",
    // ua: `
    //  vim.g.signature_help_config = { contentsStyle = "remainingLabels", viewStyle = "virtual" }
    //  vim.fn["signature_help#enable"]()
    // ,
  },
  {
    org: "nvim-tree",
    repo: "nvim-web-devicons",
    lua_post: `require("nvim-web-devicons").setup({ default = true })`,
  },
  {
    org: "catppuccin",
    repo: "nvim",
    lua_post: `
        require("catppuccin").setup({
          integrations = {
            aerial = true,
            bufferline = true,
            gitsigns = true,
            illuminate = true,
            lsp_trouble = true,
            mason = true,
            notify = true,
            nvimtree = true,
            sandwich = true,
            semantic_tokens = true,
            treesitter = true,
            treesitter_context = true,

            native_lsp = {
              enabled = true,
            },
          },
        })
        vim.cmd([[colorscheme catppuccin-mocha]])
      `,
  },
  {
    org: "rcarriga",
    repo: "nvim-notify",
    lua_post: `
      local notify = require("notify")
      notify.setup({
        stages = "slide",
      })
      vim.notify = notify
    `,
  },
  {
    org: "gen740",
    repo: "SmoothCursor.nvim",
    lua_post: `
      require("smoothcursor").setup({
        disable_float_win = true,
        priority = 100,
        autostart = true,
        threshold = 1,
        speed = 18,
        type = "exp",
        intervals = 22,
        fancy = {
          enable = true,
          head = { cursor = "", texthl = "SmoothCursor" },
          body = {
            { cursor = "●", texthl = "SmoothCursorBody" },
            { cursor = "●", texthl = "SmoothCursorBody" },
            { cursor = "•", texthl = "SmoothCursorBody" },
            { cursor = "•", texthl = "SmoothCursorBody" },
            { cursor = "∙", texthl = "SmoothCursorBody" },
            { cursor = "∙", texthl = "SmoothCursorBody" },
          },
        },
        -- flyin_effect = 'bottom',
      })

      -- normal mode as default
      vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#8aa872" })
      vim.api.nvim_set_hl(0, "SmoothCursorBody", { fg = "#8aa872" })

      vim.api.nvim_create_autocmd("ModeChanged", {
        callback = function()
          local current_mode = vim.fn.mode()
          if current_mode == "n" then
            vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#8aa872" })
            vim.api.nvim_set_hl(0, "SmoothCursorBody", { fg = "#8aa872" })
            vim.fn.sign_define("smoothcursor", { text = "" })
          elseif current_mode == "v" then
            vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#bf616a" })
            vim.api.nvim_set_hl(0, "SmoothCursorBody", { fg = "#bf616a" })
            vim.fn.sign_define("smoothcursor", { text = "" })
          elseif current_mode == "V" then
            vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#bf616a" })
            vim.api.nvim_set_hl(0, "SmoothCursorBody", { fg = "#bf616a" })
            vim.fn.sign_define("smoothcursor", { text = "" })
          elseif current_mode == "" then
            vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#bf616a" })
            vim.api.nvim_set_hl(0, "SmoothCursorBody", { fg = "#bf616a" })
            vim.fn.sign_define("smoothcursor", { text = "" })
          elseif current_mode == "i" then
            vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#668aab" })
            vim.api.nvim_set_hl(0, "SmoothCursorBoby", { fg = "#668aab" })
            vim.fn.sign_define("smoothcursor", { text = "" })
          end
        end,
      })
    `,
  },
  {
    org: "windwp",
    repo: "nvim-autopairs",
    lua_post: `require("nvim-autopairs").setup()`,
  },
  {
    org: "lewis6991",
    repo: "gitsigns.nvim",
    lua_post: `require("gitsigns").setup()`,
  },
  {
    org: "hrsh7th",
    repo: "vim-vsnip",
  },
  {
    org: "hrsh7th",
    repo: "vim-vsnip-integ",
  },
  {
    org: "rafamadriz",
    repo: "friendly-snippets",
  },
  {
    org: "monaqa",
    repo: "modesearch.nvim",
    lua_pre: `
      vim.keymap.set("n", "/", function() return require("modesearch").keymap.prompt.show("rawstr") end, { expr = true })
      vim.keymap.set(
        "c",
        "<C-x>",
        function() return require("modesearch").keymap.mode.cycle({ "rawstr", "migemo", "regexp" }) end,
        { expr = true }
      )
    `,
    lua_post: `
      require("modesearch").setup({
        modes = {
          rawstr = {
            prompt = "[rawstr]/",
            converter = function(query) return [[\\V]] .. vim.fn.escape(query, [[/\]]) end,
          },
          regexp = {
            prompt = "[regexp]/",
            converter = function(query) return [[\\v]] .. vim.fn.escape(query, [[/]]) end,
          },
          migemo = {
            prompt = "[migemo]/",
            converter = function(query) return [[\\v]] .. vim.fn["kensaku#query"](query) end,
          },
        },
      })
    `,
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
      local lspconfig = require("lspconfig")
      lspconfig.gopls.setup({})
      lspconfig.lua_ls.setup({})
      lspconfig.terraformls.setup({})
      lspconfig.denols.setup({
        init_options = {
          lint = true,
        },
      })
    `,
  },
  {
    org: "j-hui",
    repo: "fidget.nvim",
    lua_post: `require("fidget").setup({})`,
  },
  {
    org: "nvim-treesitter",
    repo: "nvim-treesitter",
    lua_post: `
      require("nvim-treesitter.configs").setup({
        sync_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          disable = function(lang)
            local byte_size = vim.api.nvim_buf_get_offset(0, vim.api.nvim_buf_line_count(0))
            if byte_size > 1024 * 1024 then return true end

            if not pcall(function() vim.treesitter.get_parser(0, lang):parse() end) then return true end
            if not pcall(function() vim.treesitter.query.get(lang, "highlights") end) then return true end

            return false
          end,
        },
      })
    `,
  },
  {
    org: "nvim-treesitter",
    repo: "nvim-treesitter-context",
    lua_post: `require("treesitter-context").setup()`,
  },
];
