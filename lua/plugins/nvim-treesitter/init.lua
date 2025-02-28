return {
  "nvim-treesitter/nvim-treesitter",
  version = "*",
  build = ":TSUpdate",
  event = "VeryLazy",
  import = vim.g.lazy_plugins .. ".nvim-treesitter",
}
