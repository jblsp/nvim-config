return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		"nvim-telescope/telescope-ui-select.nvim",
	},

	opts = {
		defaults = {
			mappings = {
				n = {
					["q"] = function(buf)
						require("telescope.actions").close(buf)
					end,
				},
			},
		},
	},
	keys = {
		{
			"<leader>sh",
			function()
				require("telescope.builtin").help_tags()
			end,
			desc = "Search Help",
		},
		{
			"<leader>sk",
			function()
				require("telescope.builtin").keymaps()
			end,
			desc = "Search Keymaps",
		},
		{
			"<leader>sf",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "Search Files",
		},
		{
			"<leader>st",
			function()
				require("telescope.builtin").builtin()
			end,
			desc = "Search Telescope Builtin",
		},
		{
			"<leader>sw",
			function()
				require("telescope.builtin").grep_string()
			end,
			desc = "Grep Current Word",
		},
		{
			"<leader>sg",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Search by Grep",
		},
		{
			"<leader>sd",
			function()
				require("telescope.builtin").diagnostics()
			end,
			desc = "Search Diagnostics",
		},
		{
			"<leader>sr",
			function()
				require("telescope.builtin").resume()
			end,
			desc = "Search Resume",
		},
		{
			"<leader>s.",
			function()
				require("telescope.builtin").oldfiles()
			end,
			desc = "Search Recent Files",
		},
		{
			"<leader>sb",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Search Buffers",
		},
		{
			"<leader>/",
			function()
				local dropdown = require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				})
				require("telescope.builtin").current_buffer_fuzzy_find(dropdown)
			end,
			desc = "Fuzzily Search in Current Buffer",
		},
		{
			"<leader>sn",
			function()
				require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Search Neovim Files",
		},
		{
			"<leader>s/",
			function()
				require("telescope.builtin").live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end,
			desc = "Live Grep in Open Files",
		},
		{
			"z=",
			function()
				require("telescope.builtin").spell_suggest({})
			end,
			desc = "Spelling suggestions",
		},
	},
	config = function(_, opts)
		local extensions = {}
		local function setup_extension(ext, ext_opts)
			if opts.extensions == nil then
				opts.extensions = {}
			end
			if ext_opts then
				opts.extensions = vim.tbl_deep_extend("force", {}, opts.extensions, { [ext] = ext_opts })
			end
			extensions = vim.fn.insert(extensions, ext)
		end

		-- setup extensions here
		setup_extension("ui-select", require("telescope.themes").get_dropdown({}))
		setup_extension("fzf")

		require("telescope").setup(opts)
		for _, ext in ipairs(extensions) do
			require("telescope").load_extension(ext)
		end

		util.lsp_map("n", "gd", function()
			require("telescope.builtin").lsp_definitions()
		end, { desc = "Go to Definition" })
		util.lsp_map("n", "gr", function()
			require("telescope.builtin").lsp_references()
		end, { desc = "Go to References" })
		util.lsp_map("n", "gI", function()
			require("telescope.builtin").lsp_implementations()
		end, { desc = "Go to Implementation" })
		util.lsp_map("n", "gy", function()
			require("telescope.builtin").lsp_type_definitions()
		end, { desc = "Go to Type Definition" })
		util.lsp_map("n", "<leader>ls", function()
			require("telescope.builtin").lsp_document_symbols()
		end, { desc = "Document Symbols" })
		util.lsp_map("n", "<leader>ls", function()
			require("telescope.builtin").lsp_dynamic_workspace_symbols()
		end, { desc = "Workspace Symbols" })
	end,
}
