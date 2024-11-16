return {
	"nvim-treesitter/nvim-treesitter",
	version = "*",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
	opts = {
		ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
		ignore_install = {},
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = { enable = true },
		incremental_selection = {
			enabled = true,
			keymaps = {
				--TODO: Set good keymaps
				init_selection = false,
				node_incremental = false,
				scope_incremental = false,
				node_decremental = false,
			},
		},
	},
}
