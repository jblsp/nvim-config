return {
  "folke/snacks.nvim",
  enabled = true,
  version = "*",
  priority = 1000,
  lazy = false,
  import = vim.g.lazy_plugins .. ".snacks",
}
