_G.util = {
  add = function(tbl)
    for name, val in pairs(tbl) do
      _G.util[name] = val
    end
  end,
}

util.add(require("util.colorscheme"))
util.add(require("util.helper"))
util.add(require("util.keymap"))
util.add(require("util.toggle"))
util.add(require("util.lsp_capabilities"))
