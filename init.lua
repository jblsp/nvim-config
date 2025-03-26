-- Globals
vim.g.startup_colors = "duskfox"
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Opts
vim.opt.breakindent = true -- Indent wrapped lines
vim.opt.confirm = true -- Confirm to save changes when exiting modified buffer
vim.opt.cursorline = true -- Highlight current line
vim.opt.cursorlineopt = "number" -- Only highlight number of current line
vim.opt.foldexpr = "v:lua.require'joe.util.fold'.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldmethod = "expr"
vim.opt.ignorecase = true -- Case-insensitive searching
vim.opt.inccommand = "split"
vim.opt.infercase = true
vim.opt.laststatus = 3 -- Global status line
vim.opt.linebreak = true
vim.opt.mouse = "a"
vim.opt.mousemodel = "extend"
vim.opt.number = true -- Line numbers
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.showtabline = 1
vim.opt.signcolumn = "yes" -- Always enable sign column
vim.opt.smartcase = true -- Case sensitive searching if \C or one or more capital letters in search
vim.opt.smoothscroll = true -- scroll by screen line rather than by text line when 'wrap' is set
vim.opt.spelllang = { "en" }
vim.opt.undofile = true -- Save undo history for files
vim.opt.undolevels = 10000
vim.opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
vim.opt.wrap = false

-- Keymaps
local map = vim.keymap.set

-- escape removes search highlights
map("n", "<Esc>", "<cmd>noh<cr>")

-- buffers
map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New buffer" })
map("n", "<leader>bl", "<cmd>b#<cr>", { desc = "Last buffer" })
map("n", "<leader>bD", "<cmd>bd<cr>", { desc = "Delete buffer and window" })

-- tabs
map("n", "[t", "<cmd>tabprev<cr>", { desc = "Previous tab" })
map("n", "]t", "<cmd>tabnext<cr>", { desc = "Next tab" })
map("n", "<leader>td", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Close other tabs" })
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New tab" })

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

-- (from LazyVim) https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Terminal mappings
map("t", "<esc><esc>", "<c-\\><c-n>")

-- Global LSP Configuration
vim.lsp.config("*", {
  root_markers = { ".git" },
})

-- Enabled language servers
vim.lsp.enable({
  "lua_ls",
  "pyright",
})

require("joe.lazy")

vim.cmd.colorscheme(vim.g.startup_colors)
