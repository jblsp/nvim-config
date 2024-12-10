-- escape removes search highlights and clears cmdline
vim.keymap.set("n", "<Esc>", "<cmd>echo ''<cr><cmd>noh<cr>")

-- buffers
vim.keymap.set("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New Buffer" })
vim.keymap.set("n", "<leader>bl", "<cmd>b#<cr>", { desc = "Last Buffer" })
vim.keymap.set("n", "[b", "<cmd>bprev<cr>", { desc = "Previous Buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

vim.keymap.set("n", "<leader>y", function()
  vim.fn.setreg("+", vim.fn.getreg('"'))
end, { desc = "Copy Anon Register to System Clipboard" })
vim.keymap.set("n", "yc", "yygccp", { remap = true, desc = "Duplicate line and comment out original" })

-- LSP mappings
util.lsp_map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
util.lsp_map("n", "<leader>rs", vim.lsp.buf.rename, { desc = "Rename Symbol" })
util.lsp_map({ "n", "x" }, "<leader>lc", vim.lsp.buf.code_action, { desc = "Code Action" })
