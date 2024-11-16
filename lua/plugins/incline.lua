return {
	"b0o/incline.nvim",
	opts = {
		hide = {
			only_win = true,
		},
		highlight = {
			groups = {
				InclineNormal = "AerialLine",
				InclineNormalNC = "StatusLine",
			},
		},
		window = {
			padding = 0,
			margin = { horizontal = 0 },
		},
		ignore = {
			buftypes = { "nofile" },
			unlisted_buffers = false,
		},
		render = function(props)
			local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
			if filename == "" then
				filename = "[No Name]"
			end

			return {
				{ " " },
				{ filename },
				{ vim.bo[props.buf].modified and " ●" or "" },
				{ vim.bo[props.buf].ro and " ⊘" or "" },
				{ " " },
			}
		end,
	},
}
