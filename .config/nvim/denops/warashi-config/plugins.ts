import { z } from "https://deno.land/x/zod@v3.21.4/mod.ts";

const GitHubPlugin = z.object({
  org: z.string(),
  repo: z.string(),
  lua_pre: z.string().optional(),
  lua_post: z.string().optional(),
});

const GitPlugin = z.object({
  url: z.string(),
  dst: z.string(),
  lua_pre: z.string().optional(),
  lua_post: z.string().optional(),
});

export type GitHubPlugin = z.infer<typeof GitHubPlugin>;
export type GitPlugin = z.infer<typeof GitPlugin>;
export type Plugin = GitPlugin | GitHubPlugin;

export function isGitPlugin(x: unknown): x is GitPlugin {
  return GitPlugin.safeParse(x).success;
}
export function isGitHubPlugin(x: unknown): x is GitHubPlugin {
  return GitHubPlugin.safeParse(x).success;
}

export const plugins: Plugin[] = [
  { org: "vim-denops", repo: "denops.vim" },
  { org: "lambdalisue", repo: "kensaku.vim" },
  { org: "MunifTanjim", repo: "nui.nvim" },
  { org: "nvim-lua", repo: "plenary.nvim" },
  { org: "Shougo", repo: "pum.vim" },
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
    lua_post: `vim.fn["popup_preview#enable"]()`,
  },
  {
    org: "matsui54",
    repo: "denops-signature_help",
    lua_post: `
      vim.g.signature_help_config = { contentsStyle = "remainingLabels", viewStyle = "virtual" }
      vim.fn["signature_help#enable"]()
    `,
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
            converter = function(query) return [[\\V]] .. vim.fn.escape(query, [[/\\]]) end,
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

  // ddc
  { org: "Shougo", repo: "ddc-around" },
  { org: "Shougo", repo: "ddc-cmdline" },
  { org: "Shougo", repo: "ddc-cmdline-history" },
  { org: "Shougo", repo: "ddc-nvim-lsp" },
  { org: "Shougo", repo: "ddc-zsh" },
  { org: "Shougo", repo: "ddc-ui-pum" },
  { org: "LumaKernel", repo: "ddc-file" },
  { org: "tani", repo: "ddc-fuzzy" },
  { org: "matsui54", repo: "ddc-buffer" },
  {
    org: "Shougo",
    repo: "ddc.vim",
    lua_post: `
      local patch_global = vim.fn["ddc#custom#patch_global"]

      local function complete_or_select(rel)
        if vim.fn["pum#visible"]() then
          vim.fn["pum#map#select_relative"](rel)
        else
          return vim.fn["ddc#map#manual_complete"]()
        end
      end

      -- pum
      patch_global("ui", "pum")
      vim.keymap.set(
        "i",
        "<C-n>",
        function() return complete_or_select(1) end,
        { silent = true, expr = true, replace_keycodes = false }
      )
      vim.keymap.set(
        "i",
        "<C-p>",
        function() return complete_or_select(-1) end,
        { silent = true, expr = true, replace_keycodes = false }
      )
      vim.keymap.set("i", "<C-y>", function() vim.fn["pum#map#confirm"]() end)
      vim.keymap.set("i", "<C-e>", function() vim.fn["pum#map#cancel"]() end)

      -- sources
      patch_global("sources", { "nvim-lsp", "buffer", "around", "file", "vsnip", "zsh" })
      patch_global("sourceOptions", {
        around = { mark = "A" },
        ["nvim-lsp"] = { mark = "L" },
        file = {
          mark = "F",
          isVolatile = true,
          forceCompletionPattern = [[\S/\S*]],
        },
        buffer = { mark = "B" },
        cmdline = { mark = "CMD" },
        ["cmdline-history"] = { mark = "CMD" },
        zsh = { mark = "Z" },
        ["_"] = {
          matchers = { "matcher_fuzzy" },
          sorters = { "sorter_fuzzy" },
          converters = { "converter_fuzzy" },
        },
      })
      patch_global("sourceParams", {
        around = { maxSize = 500 },
      })

      -- cmdline
      local function commandline_post(maps)
        for lhs, _ in pairs(maps) do
          pcall(vim.keymap.del, "c", lhs)
        end
        if vim.b.prev_buffer_config ~= nil then
          vim.fn["ddc#custom#set_buffer"](vim.b.prev_buffer_config)
          vim.b.prev_buffer_config = nil
        else
          vim.fn["ddc#custom#set_buffer"]({})
        end
      end

      local function commandline_pre()
        local maps = {
          ["<C-n>"] = function() vim.fn["pum#map#insert_relative"](1) end,
          ["<C-p>"] = function() vim.fn["pum#map#insert_relative"](-1) end,
        }
        for lhs, rhs in pairs(maps) do
          vim.keymap.set("c", lhs, rhs)
        end
        if vim.b.prev_buffer_config == nil then
          -- Overwrite sources
          vim.b.prev_buffer_config = vim.fn["ddc#custom#get_buffer"]()
        end
        vim.fn["ddc#custom#patch_buffer"]("cmdlineSources", { "cmdline", "cmdline-history", "file", "around" })
        vim.api.nvim_create_autocmd("User", {
          pattern = "DDCCmdLineLeave",
          once = true,
          callback = function() pcall(commandline_post, maps) end,
        })
        vim.api.nvim_create_autocmd("InsertEnter", {
          once = true,
          buffer = 0,
          callback = function() pcall(commandline_post, maps) end,
        })

        -- Enable command line completion
        vim.fn["ddc#enable_cmdline_completion"]()
      end

      vim.keymap.set("n", ":", function()
        commandline_pre()
        return ":"
      end, { expr = true, remap = true })
      patch_global(
        "autoCompleteEvents",
        { "InsertEnter", "TextChangedI", "TextChangedP", "CmdlineEnter", "CmdlineChanged" }
      )
      patch_global("cmdlineSources", { "cmdline", "cmdline-history", "file", "around" })

      -- enable
      vim.fn["ddc#enable"]()
    `,
  },

  // ddu
  {
    org: "github",
    repo: "copilot.vim",
    lua_pre: `vim.g.copilot_no_maps = true`,
  },
  { org: "Warashi", repo: "ddu-source-copilot" },
  { org: "Shougo", repo: "ddu-ui-ff" },
  { org: "matsui54", repo: "ddu-vim-ui-select" },
  { org: "4513ECHO", repo: "ddu-source-emoji" },
  { org: "4513ECHO", repo: "ddu-source-source" },
  { org: "Shougo", repo: "ddu-source-line" },
  { org: "Shougo", repo: "ddu-source-register" },
  { org: "matsui54", repo: "ddu-source-command_history" },
  { org: "shun", repo: "ddu-source-buffer" },
  { org: "tyru", repo: "open-browser.vim" },
  { org: "4513ECHO", repo: "ddu-kind-url" },
  { org: "Shougo", repo: "ddu-kind-file" },
  { org: "Shougo", repo: "ddu-kind-word" },
  { org: "Milly", repo: "ddu-filter-kensaku" },
  {
    org: "Shougo",
    repo: "ddu.vim",
    lua_pre: `
      local start = vim.fn["ddu#start"]
      vim.keymap.set("n", "<leader>d", function() start({ sources = { { name = "source" } } }) end)
      vim.keymap.set("i", "<C-x><C-l>", function() start({ sources = { { name = "copilot", options = { defaultAction = "append" } } } }) end)
      vim.keymap.set("i", "<C-x><C-e>", function() start({ sources = { { name = "emoji", options = { defaultAction = "append" } } } }) end)
    `,
    lua_post: `
      local patch_global = vim.fn["ddu#custom#patch_global"]

      -- ui
      patch_global("ui", "ff")
      patch_global("uiParams", {
        ff = {
          split = "floating",
          floatingBorder = "single",
        },
      })

      -- sources
      patch_global("sources", {})
      patch_global("sourceOptions", {
        ["_"] = { matchers = { "matcher_kensaku" } },
      })
      patch_global("sourceParams", {})

      --- kinds
      patch_global("kindOptions", {
        command_history = { defaultAction = "edit" },
        file = { defaultAction = "open" },
        source = { defaultAction = "execute" },
        ui_select = { defaultAction = "select" },
        url = { defaultAction = "browse" },
        word = { defaultAction = "append" },
      })

      -- key-bindings
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ddu-ff",
        callback = function()
          local action = vim.fn["ddu#ui#ff#do_action"]
          local opts = { buffer = true }
          vim.keymap.set("n", "<CR>", function() action("itemAction") end, opts)
          vim.keymap.set("n", "<Space>", function() action("toggleSelectItem") end, opts)
          vim.keymap.set("n", "i", function() action("openFilterWindow") end, opts)
          vim.keymap.set("n", "q", function() action("quit") end, opts)
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "ddu-ff-filter",
        callback = function()
          local opts = { buffer = true }
          vim.keymap.set("i", "<CR>", "<Esc><Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>", opts)
          vim.keymap.set("n", "<CR>", "<Cmd>call ddu#ui#do_action('closeFilterWindow')<CR>", opts)
        end,
      })
    `,
  },
];
