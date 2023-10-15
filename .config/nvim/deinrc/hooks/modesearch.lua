-- lua_add {{{
vim.keymap.set("n", "/", function() return require("modesearch").keymap.prompt.show("migemo") end, { expr = true })
vim.keymap.set(
  "c",
  "<C-x>",
  function() return require("modesearch").keymap.mode.cycle({ "migemo", "rawstr", "regexp" }) end,
  { expr = true }
)
-- }}}

-- lua_source {{{
require("modesearch").setup({
  modes = {
    rawstr = {
      prompt = "[rawstr]/",
      converter = function(query) return [[\V]] .. vim.fn.escape(query, [[/\]]) end,
    },
    regexp = {
      prompt = "[regexp]/",
      converter = function(query) return [[\v]] .. vim.fn.escape(query, [[/]]) end,
    },
    migemo = {
      prompt = "[migemo]/",
      converter = function(query) return [[\v]] .. vim.fn["kensaku#query"](query) end,
    },
  },
})
-- }}}
