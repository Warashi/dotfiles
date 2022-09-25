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
  },
})
