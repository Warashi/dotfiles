local function condition()
  if (1 == vim.fn["denops#plugin#is_loaded"]("lspoints")) then
    return (0 < #vim.fn["lspoints#get_clients"]())
  else
    return false
  end
end
local function init(self)
  if not rawget(self, "once") then
    local function _2_()
      self["_win_cache"] = nil
      return nil
    end
    return vim.api.nvim_create_autocmd("BufWinEnter", {callback = _2_})
  else
    self["once"] = true
    return nil
  end
end
local function provider(_)
  local format = "\239\144\163 [%s]"
  local servers
  do
    local tbl_17_auto = {}
    local i_18_auto = #tbl_17_auto
    for _0, server in ipairs(vim.fn["lspoints#get_clients"]()) do
      local val_19_auto = server.name
      if (nil ~= val_19_auto) then
        i_18_auto = (i_18_auto + 1)
        do end (tbl_17_auto)[i_18_auto] = val_19_auto
      else
      end
    end
    servers = tbl_17_auto
  end
  return format:format(table.concat(servers, ", "))
end
return {condition = condition, update = {"User", pattern = {"LspointsAttach:*", "LspointsDetach:*", "DenopsPluginPost:lspoints"}}, init = init, provider = provider, hl = {fg = "green", bold = true}}
