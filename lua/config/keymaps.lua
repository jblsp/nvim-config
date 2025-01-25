local map = vim.keymap.set

-- escape removes search highlights and clears cmdline
map("n", "<Esc>", "<cmd>echo ''<cr><cmd>noh<cr>")

-- buffers
map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New Buffer" })
map("n", "<leader>bl", "<cmd>b#<cr>", { desc = "Last Buffer" })
map("n", "[b", "<cmd>bprev<cr>", { desc = "Previous Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

map("n", "<leader>y", util.fn.anontoclip, { desc = "Copy Anon Register to System Clipboard" })
map("n", "yc", "yygccp", { remap = true, desc = "Duplicate line and comment out original" })

-- LSP mappings
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
map("n", "<leader>rs", vim.lsp.buf.rename, { desc = "Rename Symbol" })
map({ "n", "x" }, "<leader>lc", vim.lsp.buf.code_action, { desc = "Code Action" })
