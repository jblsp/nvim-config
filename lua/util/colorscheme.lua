local M = {}

function M.create_colorscheme_spec(short_url, name, opts)
	opts = opts or {}
	local spec = {
		[1] = short_url,
		name = name,
		priority = 1000,
		lazy = true,
		opts = opts,
	}
	if vim.g.colorscheme == name then
		spec.init = function()
			vim.cmd.colorscheme(name)
		end
	end
	return spec
end

return M
