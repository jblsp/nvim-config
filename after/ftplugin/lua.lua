local opt = vim.opt_local

opt.softtabstop = -1
opt.expandtab = true
opt.shiftwidth = 2

local map = vim.keymap.set

map("n", "<localleader>X", "<cmd>source %<cr>", { desc = "Execute current file" })
map("n", "<localleader>x", "<cmd>.lua<cr>", { desc = "Execute current line" })
map("v", "<localleader>x", ":lua<CR>", { desc = "Execute current selection" })
