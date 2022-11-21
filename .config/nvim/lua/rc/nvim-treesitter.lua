require("nvim-treesitter.parsers").get_parser_configs().cue = {
  install_info = {
    url = "https://github.com/eonpatapon/tree-sitter-cue", -- local path or git repo
    files = { "src/parser.c", "src/scanner.c" },
    branch = "main",
  },
  filetype = "cue", -- if filetype does not agrees with parser name
}

require("nvim-treesitter.configs").setup({
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = function(lang)
      local byte_size = vim.api.nvim_buf_get_offset(0, vim.api.nvim_buf_line_count(0))
      if byte_size > 1024 * 1024 then return true end

      if not pcall(function() vim.treesitter.get_parser(0, lang):parse() end) then return true end
      if not pcall(function() vim.treesitter.get_query(lang, "highlights") end) then return true end

      return false
    end,
  },
})
