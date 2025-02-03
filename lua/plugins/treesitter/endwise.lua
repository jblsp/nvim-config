return {
  "nvim-treesitter",
  main = "nvim-treesitter.configs",
  dependencies = { "RRethy/nvim-treesitter-endwise" },
  opts = {
    endwise = { enable = true },
  },
}
