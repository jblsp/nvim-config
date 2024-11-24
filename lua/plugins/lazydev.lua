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
  { -- blink completion source
    "saghen/blink.cmp",
    opts = function(_, opts)
      table.insert(opts.sources.completion.enabled_providers, "lazydev")
      vim.tbl_deep_extend("force", opts.providers or {}, {
        lsp = { fallback_for = { "lazydev" } },
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
      })
    end,
  },
}
