local opt = vim.opt_local

opt.expandtab = true
opt.shiftwidth = 2

vim.keymap.set("n", "<leader>X", "<cmd>source %<cr>", { desc = "Execute current file" })
vim.keymap.set("n", "<leader>x", "<cmd>.lua<cr>", { desc = "Execute current line" })
vim.keymap.set("v", "<leader>x", ":lua<CR>", { desc = "Execute current selection" })
