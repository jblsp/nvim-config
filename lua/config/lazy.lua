vim.g.lazy_plugins = "plugins"

load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()

require("lazy").setup({
  spec = {
    { import = vim.g.lazy_plugins },
  },
  defaults = {
    lazy = true,
  },
  lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
  install = { colorscheme = { vim.g.startup_colors } },
  checker = { enabled = true },
  rocks = {
    hererocks = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "netrw",
        "netrwPlugin",
      },
    },
  },
  ui = {
    backdrop = 85,
  },
  custom_keys = {
    ["<localleader>l"] = false,
    ["<localleader>t"] = false,
  },
})
