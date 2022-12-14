local job = require("plenary.job")
local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

local go_module = nil
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    job
      :new({
        command = "go",
        args = { "list", "-m" },
        on_exit = function(j, return_val)
          if return_val == 0 then go_module = j:result()[1] end
        end,
      })
      :start()
  end,
})

local my_source_gci = {}
my_source_gci.name = "my-source-gci"
my_source_gci.method = null_ls.methods.FORMATTING
my_source_gci.filetypes = { "go" }
my_source_gci.generator = helpers.formatter_factory({
  command = "gci",
  args = function()
    return {
      "print",
      "$FILENAME",
      "--skip-generated",
      "--custom-order",
      "--section",
      "standard,default,prefix(" .. go_module .. "),blank,dot",
    }
  end,
  to_stdin = true,
  from_temp_file = true,
})

null_ls.register(my_source_gci)
return { source = my_source_gci }
