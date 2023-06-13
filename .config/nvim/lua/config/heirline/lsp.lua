local conditions = require("heirline.conditions")

return {
  condition = conditions.lsp_attached,
  update = { "LspAttach", "LspDetach", "WinEnter" },
  provider = function(_)
    local servers = {}
    for _, server in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      if server.name ~= "null-ls" then
        table.insert(servers, server.name)
      else
        local sources = {}
        for _, source in ipairs(require("null-ls.sources").get_available(vim.bo.filetype)) do
          table.insert(sources, source.name)
        end
        table.insert(servers, ("null-ls(%s)"):format(table.concat(sources, ", ")))
      end
    end
    return (" [%s]"):format(table.concat(servers, ", "))
  end,
  hl = { fg = "green", bold = true },
}
