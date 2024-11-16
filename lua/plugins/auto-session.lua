return {
	"rmagatti/auto-session",
	version = false, -- the latest release v2.5.0 is missing some features i'm using
	lazy = false,
	keys = {
		{
			"<leader>ss",
			"<cmd>SessionSearch<cr>",
			desc = "Search Sessions",
		},
	},
	opts = {
		suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
		bypass_save_filetypes = { "dashboard", "alpha", "netrw", "minifiles" },
		auto_create = util.in_git_project,
		session_lens = {
			load_on_setup = false,
			mappings = {
				delete_session = { { "n", "i" }, "<C-D>" },
				alternate_session = { { "n", "i" }, "<C-S>" },
				copy_session = { { "n", "i" }, "<C-Y>" },
			},
		},
		pre_restore_cmds = {
			function()
				vim.api.nvim_exec_autocmds("User", { pattern = "SessionLoadPre" })
			end,
		},
	},
	init = function()
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
	end,
}
