local M = {}

function M.create_colorscheme_spec(short_url, name, opts)
	opts = opts or {}
	local spec = {
		[1] = short_url,
		name = name,
		priority = 1000,
		lazy = not (name == vim.g.colorscheme),
		opts = opts,
	}
	return spec
end

return M
