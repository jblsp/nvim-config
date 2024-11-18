return {
	"stevearc/conform.nvim",
	version = "*",
	event = "BufWritePre",
	cmd = { "ConformInfo" },
	dependencies = {
		{ "zapling/mason-conform.nvim", dependencies = "mason.nvim" },
	},
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			if vim.g.autoformat == false or vim.b[bufnr].autoformat == false then
				return
			end
			return {
				timeout_ms = 500,
				lsp_format = "fallback",
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)
		require("mason-conform").setup()
	end,
}
