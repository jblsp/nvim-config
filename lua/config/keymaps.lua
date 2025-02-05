local map = vim.keymap.set

-- escape removes search highlights
map("n", "<Esc>", "<cmd>noh<cr>")

-- buffers
map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New buffer" })
map("n", "<leader>bl", "<cmd>b#<cr>", { desc = "Last buffer" })
map("n", "[b", "<cmd>bprev<cr>", { desc = "Previous buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize -2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize +2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Clipboard
map("n", "<leader>cc", util.fn.anon_to_clip, { desc = 'Copy anon register (") to system clipboard' })
map({ "n", "x" }, "<leader>cy", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>cp", '"+p', { desc = "Paste from system clipboard" })
map("x", "<leader>cp", '"+P', { desc = "Paste from system clipboard" })

-- Comments
map("n", "yc", "yygccp", { remap = true, desc = "Duplicate line and comment out original" })

-- LSP mappings
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "<leader>rs", vim.lsp.buf.rename, { desc = "Rename symbol" })
map({ "n", "x" }, "<leader>lc", vim.lsp.buf.code_action, { desc = "Code action" })
