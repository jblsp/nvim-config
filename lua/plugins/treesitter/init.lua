return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = "*",
    build = ":TSUpdate",
    event = "VeryLazy",
    import = "plugins.treesitter",
  },
  { "nvim-treesitter/nvim-treesitter-context", event = "VeryLazy" },
}
