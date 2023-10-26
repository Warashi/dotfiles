-- lua_source {{{
local function loadSnippetDir(dir, name, filetype)
  if vim.startswith(dir, ".") then return end
  if name == "global.json" then return end
  if not vim.endswith(name, ".json") then return end
  if vim.fn.isdirectory(dir .. "/" .. name) == 0 then
    vim.fn["denippet#load"](dir .. "/" .. name, filetype)
    return
  else
    for subname, _ in vim.fs.dir(dir .. "/" .. name) do
      loadSnippetDir(dir .. "/" .. name, subname, filetype)
    end
  end
end
local function initializeDenippet()
  local root = vim.fn.stdpath("cache") .. "/dpp/repos/github.com/rafamadriz/friendly-snippets/snippets"

  for name, _ in vim.fs.dir(root) do
    loadSnippetDir(root, name, { name })
  end
end
-- initializeDenippet()
-- }}}
