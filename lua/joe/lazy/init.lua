vim.g.lazy_plugins = "joe.lazy.plugins"

load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()

require("lazy").setup({
  defaults = {
    lazy = true,
  },
  spec = {
    { import = vim.g.lazy_plugins },
  },
  lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
  install = { colorscheme = { vim.g.startup_colors } },
  checker = { enabled = true },
  rocks = {
    hererocks = false,
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "netrw",
        "netrwPlugin",
      },
    },
  },
})
