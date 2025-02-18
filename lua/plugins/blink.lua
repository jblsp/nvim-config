return {
  "saghen/blink.cmp",
  version = "*",
  dependencies = "rafamadriz/friendly-snippets",
  event = { "InsertEnter", "CmdlineEnter" },
  init = function()
    util.lsp_capabilities.modify(function()
      return require("blink.cmp").get_lsp_capabilities({}, true)
    end)
  end,
  opts = {
    appearance = {
      use_nvim_cmp_as_default = true,
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
}
