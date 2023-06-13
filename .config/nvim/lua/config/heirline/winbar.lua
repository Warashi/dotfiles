local align = { provider = "%=" }
local space = { provider = " " }
return {
  require("config.heirline.navic"),
  align,
  require("config.heirline.git"),
}
