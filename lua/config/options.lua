-- Globals
vim.g.colorscheme = "tokyonight" -- Can either be a built-in colorscheme or a plugin from /lua/plugins/colorschemes
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Opts
vim.opt.breakindent = true -- Indent wrapped lines
vim.opt.confirm = true -- Confirm to save changes when exiting modified buffer
vim.opt.cursorline = true -- Highlight current line
vim.opt.cursorlineopt = "number" -- Only highlight number of current line
vim.opt.ignorecase = true -- Case-insensitive searching
vim.opt.inccommand = "split"
vim.opt.laststatus = 3 -- Global status line
vim.opt.linebreak = true
vim.opt.mouse = "a"
vim.opt.number = true -- Line numbers
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes" -- Always enable sign column
vim.opt.smartcase = true -- Case sensitive searching if \C or one or more capital letters in search
vim.opt.smoothscroll = true -- scroll by screen line rather than by text line when 'wrap' is set
vim.opt.spelllang = { "en" }
vim.opt.spell = false
vim.opt.termguicolors = true
vim.opt.undofile = true -- Save undo history for files
vim.opt.undolevels = 10000
vim.opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
vim.opt.wrap = false
