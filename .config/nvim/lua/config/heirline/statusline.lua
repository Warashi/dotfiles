local align = { provider = "%=" }
local space = { provider = " " }
return {
  require("config.heirline.filename"),
  align,
  require("config.heirline.lsp"),
  space,
  require("config.heirline.diagnostics"),
  space,
  require("config.heirline.ruler"),
}
