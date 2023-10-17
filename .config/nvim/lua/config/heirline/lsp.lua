return {
  condition = function()
    return vim.fn["denops#plugin#is_loaded"]("lspoints") == 1 and #(vim.fn["lspoints#get_clients"]()) > 0
  end,
  update = { "User", pattern = { "LspointsAttach:*", "LspointsDetach:*", "DenopsPluginPost:lspoints" } },
  provider = function(_)
    local servers = {}
    for _, server in ipairs(vim.fn["lspoints#get_clients"]()) do
      table.insert(servers, server.name)
    end
    return (" [%s]"):format(table.concat(servers, ", "))
  end,
  hl = { fg = "green", bold = true },
}
