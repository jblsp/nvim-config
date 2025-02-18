local map = vim.keymap.set

-- escape removes search highlights
map("n", "<Esc>", "<cmd>noh<cr>")

-- buffers
map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New buffer" })
map("n", "<leader>bl", "<cmd>b#<cr>", { desc = "Last buffer" })
map("n", "<leader>bD", "<cmd>bd<cr>", { desc = "Delete buffer and window" })
map("n", "[b", "<cmd>bprev<cr>", { desc = "Previous buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- tabs
map("n", "[t", "<cmd>tabprev<cr>", { desc = "Previous tab" })
map("n", "]t", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<leader>td", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Close other tabs" })

-- Resize window using arrow keys
map("n", "<Up>", "<cmd>resize -2<cr>", { desc = "Decrease window height by 2" })
map("n", "<Down>", "<cmd>resize +2<cr>", { desc = "Increase window height by 2" })
map("n", "<Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width by 2" })
map("n", "<Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width by 2" })
map("n", "<S-Up>", "<cmd>resize -6<cr>", { desc = "Decrease window height by 6" })
map("n", "<S-Down>", "<cmd>resize +6<cr>", { desc = "Increase window height by 6" })
map("n", "<S-Left>", "<cmd>vertical resize -6<cr>", { desc = "Decrease window width by 6" })
map("n", "<S-Right>", "<cmd>vertical resize +6<cr>", { desc = "Increase window width by 6" })

-- Clipboard
map("n", "<leader>cc", util.fn.anon_to_clip, { desc = 'Copy anon register (") to system clipboard' })
map({ "n", "x" }, "<leader>cy", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>cp", '"+p', { desc = "Paste from system clipboard" })
map("x", "<leader>cp", '"+P', { desc = "Paste from system clipboard" })

-- Comments
map("n", "gcn", "yygccp", { remap = true, desc = "Duplicate line and comment out original" })

-- LSP mappings
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "<leader>rs", vim.lsp.buf.rename, { desc = "Rename symbol" })
map({ "n", "x" }, "<leader>lc", vim.lsp.buf.code_action, { desc = "Code action" })
