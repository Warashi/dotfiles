local M = {}
local job = require("plenary.job")
local ascii = "com.apple.keylayout.US"
local current = nil

local function activate(name)
  if name == nil then return "" end

  local stdout = ""
  job
    :new({
      command = "muscat",
      args = { "input-method", "set", name },
      on_stdout = function(_, line) stdout = stdout .. line end,
    })
    :sync()
  return stdout
end

local function insert_enter() activate(current) end

local function insert_leave() current = activate(ascii) end

function M.setup()
  local id = vim.api.nvim_create_augroup("ime", {})
  vim.api.nvim_create_autocmd({ "InsertEnter" }, {
    group = id,
    pattern = "*",
    callback = insert_enter,
  })
  vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    group = id,
    pattern = "*",
    callback = insert_leave,
  })
end

return M
