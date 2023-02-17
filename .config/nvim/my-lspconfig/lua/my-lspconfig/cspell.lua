local null_ls = require("null-ls")
--
-- $XDG_CONFIG_HOME/cspell
local config_dir = "~/.config/cspell"
-- $XDG_DATA_HOME/cspell
local data_dir = "~/.local/share/cspell"
local files = {
  config = vim.fn.expand(config_dir .. "/cspell.json"),
  dotfiles = vim.fn.expand(config_dir .. "/dotfiles.txt"),
  vim = vim.fn.expand(data_dir .. "/vim.txt.gz"),
  user = vim.fn.expand(data_dir .. "/user.txt"),
}

local M = {}

local function append(opts)
  local word = opts.args
  if not word or word == "" then
    -- 引数がなければcwordを取得
    word = vim.fn.expand("<cword>"):lower()
  end

  -- bangの有無で保存先を分岐
  local dictionary_name = opts.bang and "dotfiles" or "user"

  -- shellのechoコマンドで辞書ファイルに追記
  io.popen("echo " .. word .. " >> " .. files[dictionary_name])

  -- 追加した単語および辞書を表示
  vim.notify('"' .. word .. '" is appended to ' .. dictionary_name .. " dictionary.", vim.log.levels.INFO, {})

  -- cspellをリロードするため、現在行を更新してすぐ戻す
  if vim.api.nvim_get_option_value("modifiable", {}) then
    vim.api.nvim_set_current_line(vim.api.nvim_get_current_line())
    vim.api.nvim_command("silent! undo")
  end
end

M.custom_actions = {
  name = "append-to-cspell-dictionary",
  method = null_ls.methods.CODE_ACTION,
  filetypes = {},
  generator = {
    fn = function(_)
      -- 現在のカーソル位置
      local lnum = vim.fn.getcurpos()[2] - 1
      local col = vim.fn.getcurpos()[3]

      -- 現在行のエラーメッセージ一覧
      local diagnostics = vim.diagnostic.get(0, { lnum = lnum })

      -- カーソル位置にcspellの警告が出ているか探索
      local word = ""
      local regex = "^Unknown word %((%w+)%)$"
      for _, v in pairs(diagnostics) do
        if v.source == "cspell" and v.col < col and col <= v.end_col and string.match(v.message, regex) then
          -- 見つかった場合、単語を抽出
          word = string.gsub(v.message, regex, "%1"):lower()
          break
        end
      end

      -- 警告が見つからなければ終了
      if word == "" then return end

      -- cspell_appendを呼び出すactionのリストを返却
      return {
        {
          title = 'Append "' .. word .. '" to user dictionary',
          action = function() append({ args = word }) end,
        },
        {
          title = 'Append "' .. word .. '" to dotfiles dictionary',
          action = function() append({ args = word, bang = true }) end,
        },
      }
    end,
  },
}

function M.setup_dicts()
  -- vim辞書がなければダウンロード
  if vim.fn.filereadable(files.vim) ~= 1 then
    local vim_dictionary_url = "https://github.com/iamcco/coc-spell-checker/raw/master/dicts/vim/vim.txt.gz"
    io.popen("curl -fsSLo " .. files.vim .. " --create-dirs " .. vim_dictionary_url)
  end

  -- ユーザー辞書がなければ作成
  if vim.fn.filereadable(files.user) ~= 1 then
    io.popen("mkdir -p " .. data_dir)
    io.popen("touch " .. files.user)
  end
end

--- spell ---
M.source = null_ls.builtins.diagnostics.cspell.with({
  extra_args = { "--config", files.config },
  diagnostics_postprocess = function(diagnostic) diagnostic.severity = vim.diagnostic.severity["WARN"] end,
  condition = function() return vim.fn.executable("cspell") > 0 end,
})

return M
