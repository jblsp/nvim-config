-- escape removes search highlights and clears cmdline
vim.keymap.set("n", "<Esc>", "<cmd>echo ''<cr><cmd>noh<cr>")

-- make navigation center cursor
vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz")
vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz")
vim.keymap.set({ "n", "v" }, "<C-f>", "<C-f>zz")
vim.keymap.set({ "n", "v" }, "<C-b>", "<C-b>zz")

-- buffers
vim.keymap.set("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New Buffer" })

-- write file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Write File" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Bind move to window to <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to the left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to the down window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to the up window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to the right window" })

vim.keymap.set("n", "yc", function()
	vim.fn.setreg("+", vim.fn.getreg('"'))
end, { desc = "Copy Anon Register to System Clipboard" })

-- Toggles
util.toggle.vim_opt("wrap", { buffer_local = true }):map("<leader>tw")
util.toggle.vim_opt("wrap"):map("<leader>tW")
util.toggle.vim_opt("spell", { buffer_local = true }):map("<leader>ts")
util.toggle.vim_opt("spell"):map("<leader>tS")
util.toggle.diagnostics():map("<leader>td")
util.toggle.inlay_hints():map("<leader>ti")
util.toggle.vim_var("autoformat", { buffer_local = true }):map("<leader>ta")
util.toggle.vim_var("autoformat"):map("<leader>tA")

-- LSP mappings
util.lsp_map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
util.lsp_map("n", "<leader>rs", vim.lsp.buf.rename, { desc = "Rename Symbol" })
util.lsp_map({ "n", "x" }, "<leader>lc", vim.lsp.buf.code_action, { desc = "Code Action" })
