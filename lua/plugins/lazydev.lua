return {
  {
    "folke/lazydev.nvim",
    version = "*",
    ft = "lua",
    dependencies = { "Bilal2453/luvit-meta" },
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },

        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
}
