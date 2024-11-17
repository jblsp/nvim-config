return {
	"echasnovski/mini.files",
	version = "*",
	event = "BufEnter",
	dependencies = {
		"echasnovski/mini.icons",
	},
	opts = {
		mappings = {
			go_in = "<S-cr>",
			go_in_plus = "<cr>",
			go_out = "<S-BS>",
			go_out_plus = "<BS>",
			mark_goto = "m",
			mark_set = "M",
			reset = "-",
			trim_left = "H",
			trim_right = "L",
		},
	},
	keys = {
		{
			"<leader>e",
			function()
				if not require("mini.files").close() then
					require("mini.files").open()
				end
			end,
			desc = "Open/close mini.files",
		},
		{
			"<leader>E",
			function()
				if not require("mini.files").close() then
					require("mini.files").open(vim.api.nvim_buf_get_name(0), false)
				end
			end,
			desc = "Open/close mini.files at directory of current file",
		},
	},
	config = function(_, opts)
		require("mini.files").setup(opts)

		local augroup = vim.api.nvim_create_augroup("mini-files", { clear = true })
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesBufferCreate",
			group = augroup,
			callback = function(args)
				vim.keymap.set("n", "_", function()
					local cur_entry_path = require("mini.files").get_fs_entry().path
					local dir = vim.fs.dirname(cur_entry_path)
					if vim.fn.getcwd() ~= dir then
						util.set_cwd(dir)
					end
				end, { buffer = args.data.buf_id, desc = "Set cwd to current location" })

				vim.keymap.set("n", "<Esc>", function()
					require("mini.files").close()
				end, { buffer = args.data.buf_id, desc = "Close" })
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesWindowUpdate",
			group = augroup,
			callback = function(args)
				vim.wo[args.data.win_id].number = true
				vim.wo[args.data.win_id].relativenumber = true
			end,
		})
	end,
}
