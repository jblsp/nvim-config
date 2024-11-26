return {
  "saghen/blink.cmp",
  lazy = false, -- lazy loading handled internally
  dependencies = "rafamadriz/friendly-snippets",
  version = "v0.5.*",
  init = function()
    util.lsp_capabilities.modify(function()
      return require("blink.cmp").get_lsp_capabilities({}, true)
    end)
  end,
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
