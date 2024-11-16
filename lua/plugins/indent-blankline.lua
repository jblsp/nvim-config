return {
	"lukas-reineke/indent-blankline.nvim",
	version = "*",
	main = "ibl",
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	opts = {
		indent = { char = "▎", tab_char = "▎", priority = 2 },
		scope = { show_start = false, show_end = false },
		exclude = {
			filetypes = {
				"markdown",
				"text",
			},
		},
	},
}
