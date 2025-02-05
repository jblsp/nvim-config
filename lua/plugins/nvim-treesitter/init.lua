return {
  "nvim-treesitter/nvim-treesitter",
  version = "*",
  build = ":TSUpdate",
  event = "VeryLazy",
  import = "plugins.nvim-treesitter",
}
