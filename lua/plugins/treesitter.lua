return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = "*",
    enabled = false,
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
    dependencies = { "RRethy/nvim-treesitter-endwise" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts = {
      auto_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      endwise = { enable = true },
      indent = { enable = true },
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
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile", "VeryLazy" },
    opts = { multiwindow = true, line_numbers = true, max_lines = 4 },
  },
}
