local actions = require("joe.util.actions")

local map = vim.keymap.set

-- escape removes search highlights
map("n", "<Esc>", "<cmd>noh<cr>")

-- buffers
map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New buffer" })
map("n", "<leader>bl", "<cmd>b#<cr>", { desc = "Last buffer" })
map("n", "<leader>bD", "<cmd>bd<cr>", { desc = "Delete buffer and close window" })
map("n", "<leader>bW", "<cmd>bw<cr>", { desc = "Wipeout buffer and close window" })
map("n", "<leader>bd", actions.bdelete, { desc = "Delete buffer" })
map("n", "<leader>bw", actions.bwipeout, { desc = "Wipeout buffer" })
map("n", "<leader>bo", actions.bdelete_other, { desc = "Delete all other buffers" })
map("n", "<leader>bO", "", { desc = "Wipeout all other buffers" })

-- tabs
map("n", "[t", "<cmd>tabprev<cr>", { desc = "Previous tab" })
map("n", "]t", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<leader>td", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Close other tabs" })
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New tab" })

-- Clipboard
map("n", "<leader>cc", actions.anon_to_clip, { desc = 'Copy anon register (") to system clipboard' })

map({ "n", "x" }, "<leader>cy", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>cp", '"+p', { desc = "Paste from system clipboard" })
map("x", "<leader>cp", '"+P', { desc = "Paste from system clipboard" })

-- Comments
map("n", "gcn", "yygccp", { remap = true, desc = "Duplicate line and comment out original" })
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add comment below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add comment above" })

-- (from LazyVim) https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Terminal mappings
map("t", "<esc><esc>", "<c-\\><c-n>")
