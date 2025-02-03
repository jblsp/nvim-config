return {
  "nvim-treesitter",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  main = "nvim-treesitter.configs",
  opts = {
    textobjects = {
      select = {
        enable = true,
      },
      swap = {
        enable = true,
      },
      move = {
        enable = true,
      },
      lsp_interop = {
        enable = true,
      },
    },
  },
}
