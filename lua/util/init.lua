_G.util = {
  require = function(module)
    local tbl = require(module)
    for name, val in pairs(tbl) do
      _G.util[name] = val
    end
  end,
}

util.require("util.colorscheme")
util.require("util.helper")
util.require("util.lsp_map")
util.require("util.lsp_capabilities")
