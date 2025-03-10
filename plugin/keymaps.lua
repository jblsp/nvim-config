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
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New tab" })

-- Resize window using arrow keys
-- map("n", "<Up>", "<cmd>resize -2<cr>", { desc = "Decrease window height by 2" })
-- map("n", "<Down>", "<cmd>resize +2<cr>", { desc = "Increase window height by 2" })
-- map("n", "<Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width by 2" })
-- map("n", "<Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width by 2" })
-- map("n", "<S-Up>", "<cmd>resize -6<cr>", { desc = "Decrease window height by 6" })
-- map("n", "<S-Down>", "<cmd>resize +6<cr>", { desc = "Increase window height by 6" })
-- map("n", "<S-Left>", "<cmd>vertical resize -6<cr>", { desc = "Decrease window width by 6" })
-- map("n", "<S-Right>", "<cmd>vertical resize +6<cr>", { desc = "Increase window width by 6" })

-- Clipboard
map("n", "<leader>cc", function()
  local content = vim.fn.getreg('"')
  if content ~= "" then
    if vim.fn.setreg("+", content) == 0 then
      local _, lines = content:gsub("\n", "\n")
      local out = string.format("%d line(s) copied to clipboard", lines)
      vim.api.nvim_echo({ { out } }, true, {})
    end
  end
end, { desc = 'Copy anon register (") to system clipboard' })

map({ "n", "x" }, "<leader>cy", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>cp", '"+p', { desc = "Paste from system clipboard" })
map("x", "<leader>cp", '"+P', { desc = "Paste from system clipboard" })

-- Comments
map("n", "gcn", "yygccp", { remap = true, desc = "Duplicate line and comment out original" })
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add comment below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add comment above" })

-- LSP mappings
-- stylua: ignore start
map("n", "gD", function() vim.lsp.buf.declaration() end, { desc = "Go to declaration" })
map("n", "<leader>rs", function() vim.lsp.buf.rename() end, { desc = "Rename symbol" })
map({ "n", "x" }, "<leader>lc", function() vim.lsp.buf.code_action() end, { desc = "Code action" })
-- stylua: ignore end

-- (from LazyVim) https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Snippets
vim.keymap.set({ "i", "s" }, "<Tab>", function()
  if vim.snippet.active({ direction = 1 }) then
    return "<cmd>lua vim.snippet.jump(1)<cr>"
  else
    return "<Tab>"
  end
end, { expr = true })

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  if vim.snippet.active({ direction = -1 }) then
    return "<cmd>lua vim.snippet.jump(-1)<cr>"
  else
    return "<S-Tab>"
  end
end, { expr = true })

-- diagnostics
-- stylua: ignore start
map("n", "]d", function() util.fn.goto_diagnostic(true) end, { desc = "Next Diagnostic" })
map("n", "[d", function() util.fn.goto_diagnostic(false) end, { desc = "Prev Diagnostic" })
map("n", "]e", function() util.fn.goto_diagnostic(true, "ERROR") end, { desc = "Next Error" })
map("n", "[e", function() util.fn.goto_diagnostic(false, "ERROR") end, { desc = "Prev Error" })
map("n", "]w", function() util.fn.goto_diagnostic(true, "WARN") end, { desc = "Next Warning" })
map("n", "[w", function() util.fn.goto_diagnostic(false, "WARN") end, { desc = "Prev Warning" })
-- stylua: ignore end
