local M = {
  "Shougo/ddc.vim",
  event = "InsertEnter",
  dependencies = {
    "Shougo/pum.vim",
    "vim-denops/denops.vim",

    --- plugins ---
    "Shougo/ddc-around",
    "Shougo/ddc-cmdline",
    "Shougo/ddc-cmdline-history",
    "Shougo/ddc-converter_remove_overlap",
    "Shougo/ddc-nvim-lsp",
    "Shougo/ddc-ui-pum",
    "LumaKernel/ddc-file",
    "tani/ddc-fuzzy",
  },
}

function M.config()
  local patch_global = vim.fn["ddc#custom#patch_global"]

  local function complete_or_select(rel)
    if vim.fn["pum#visible"]() then
      vim.fn["pum#map#select_relative"](rel)
    else
      return vim.fn["ddc#map#manual_complete"]()
    end
  end

  -- pum
  patch_global("ui", "pum")
  vim.keymap.set(
    "i",
    "<C-n>",
    function() return complete_or_select(1) end,
    { silent = true, expr = true, replace_keycodes = false }
  )
  vim.keymap.set(
    "i",
    "<C-p>",
    function() return complete_or_select(-1) end,
    { silent = true, expr = true, replace_keycodes = false }
  )
  vim.keymap.set("i", "<C-y>", function() vim.fn["pum#map#confirm"]() end)
  vim.keymap.set("i", "<C-e>", function() vim.fn["pum#map#cancel"]() end)

  -- sources
  patch_global("sources", { "nvim-lsp", "around", "file", "vsnip" })
  patch_global("sourceOptions", {
    around = { mark = "A", maxSize = 500 },
    ["nvim-lsp"] = { mark = "L" },
    file = {
      mark = "F",
      isVolatile = true,
      forceCompletionPattern = [[\S/\S*]],
    },
    cmdline = { mark = "CMD" },
    ["cmdline-history"] = { mark = "CMD" },
    ["_"] = {
      matchers = { "matcher_fuzzy" },
      sorters = { "sorter_fuzzy" },
      converters = { "converter_fuzzy" },
    },
  })

  -- cmdline
  local function commandline_post(maps)
    for lhs, _ in pairs(maps) do
      pcall(vim.keymap.del, "c", lhs)
    end
    if vim.b.prev_buffer_config ~= nil then
      vim.fn["ddc#custom#set_buffer"](vim.b.prev_buffer_config)
      vim.b.prev_buffer_config = nil
    else
      vim.fn["ddc#custom#set_buffer"]({})
    end
  end

  local function commandline_pre()
    local maps = {
      ["<C-n>"] = function() vim.fn["pum#map#insert_relative"](1) end,
      ["<C-p>"] = function() vim.fn["pum#map#insert_relative"](-1) end,
    }
    for lhs, rhs in pairs(maps) do
      vim.keymap.set("c", lhs, rhs)
    end
    if vim.b.prev_buffer_config == nil then
      -- Overwrite sources
      vim.b.prev_buffer_config = vim.fn["ddc#custom#get_buffer"]()
    end
    vim.fn["ddc#custom#patch_buffer"]("cmdlineSources", { "cmdline", "cmdline-history", "file", "around" })
    vim.api.nvim_create_autocmd("User", {
      pattern = "DDCCmdLineLeave",
      once = true,
      callback = function() pcall(commandline_post, maps) end,
    })
    vim.api.nvim_create_autocmd("InsertEnter", {
      once = true,
      buffer = 0,
      callback = function() pcall(commandline_post, maps) end,
    })

    -- Enable command line completion
    vim.fn["ddc#enable_cmdline_completion"]()
  end

  vim.keymap.set("n", ":", function()
    commandline_pre()
    return ":"
  end, { expr = true, remap = true })
  patch_global(
    "autoCompleteEvents",
    { "InsertEnter", "TextChangedI", "TextChangedP", "CmdlineEnter", "CmdlineChanged" }
  )
  patch_global("cmdlineSources", { "cmdline", "cmdline-history", "file", "around" })

  -- enable
  vim.fn["ddc#enable"]()
end

return M