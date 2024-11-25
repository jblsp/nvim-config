return {
  "saghen/blink.cmp",
  lazy = false, -- lazy loading handled internally
  dependencies = "rafamadriz/friendly-snippets",
  version = "v0.5.*",
  opts = {
    highlight = {
      use_nvim_cmp_as_default = true,
    },
    sources = {
      completion = {
        enabled_providers = { "lsp", "path", "snippets", "buffer" },
      },
    },

    accept = { auto_brackets = { enabled = true } },
    trigger = { signature_help = { enabled = true } },
  },
}
