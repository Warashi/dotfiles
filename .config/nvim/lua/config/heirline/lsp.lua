return {
  condition = function()
    return vim.fn["denops#plugin#is_loaded"]("lspoints") == 1 and #(vim.fn["lspoints#get_clients"]()) > 0
  end,
  update = { "User", pattern = { "LspointsAttach:*", "LspointsDetach:*", "DenopsPluginPost:lspoints" } },
  init = function(self)
    if not (rawget(self, "once")) then
      vim.api.nvim_create_autocmd("BufWinEnter", {
        callback = function() self._win_cache = nil end,
      })
      self.once = true
    end
  end,
  provider = function(_)
    local servers = {}
    for _, server in ipairs(vim.fn["lspoints#get_clients"]()) do
      table.insert(servers, server.name)
    end
    return (" [%s]"):format(table.concat(servers, ", "))
  end,
  hl = { fg = "green", bold = true },
}
