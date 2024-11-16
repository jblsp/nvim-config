return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			component_separators = "",
			section_separators = "",
		},
		sections = {
			lualine_a = {
				{
					"mode",
					fmt = function(str)
						return str:sub(1, 1)
					end,
				},
			},
			lualine_c = {
				{
					"filename",
					symbols = {
						modified = "●",
						readonly = "⊘",
					},
					cond = function()
						local bufnr = vim.api.nvim_get_current_buf()
						if vim.api.nvim_get_option_value("buftype", { buf = bufnr }) == "nofile" then
							return false
						end

						return true
					end,
				},
			},
			lualine_x = { "encoding", { "fileformat", icons_enabled = false }, "filetype" },
		},
	},
	init = function()
		vim.opt.showmode = false
		vim.opt.ruler = false -- Disable default ruler
	end,
}
