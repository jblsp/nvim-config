_G.util = {
	add = function(funcs)
		for name, func in pairs(funcs) do
			_G.util[name] = func
		end
	end,
}

util.add(require("util.helper"))
util.add(require("util.colorscheme"))
util.add(require("util.keymap"))
