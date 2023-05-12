import { Plugin } from "./types.ts";

export const ui: Plugin[] = [
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
];
