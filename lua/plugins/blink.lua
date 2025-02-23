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
    keymap = {
      preset = "none",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide" },
      ["<C-y>"] = { "select_and_accept" },
      ["<C-p>"] = { "select_prev" },
      ["<C-n>"] = { "select_next" },
      ["<C-b>"] = { "scroll_documentation_up" },
      ["<C-f>"] = { "scroll_documentation_down" },
      ["<Tab>"] = { "snippet_forward" },
      ["<S-Tab>"] = { "snippet_backward" },
      ["<C-k>"] = { "show_signature", "hide_signature" },
    },
  },
}
