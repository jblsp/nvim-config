return {
  "nvim-treesitter",
  main = "nvim-treesitter.configs",
  opts = {
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<leader><space>",
        node_incremental = "<CR>",
        scope_incremental = false,
        node_decremental = "<BS>",
      },
    },
  },
}
