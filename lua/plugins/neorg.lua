return {
  "nvim-neorg/neorg",
  version = "9.*",
  ft = "norg",
  cmd = "Neorg",
  dependencies = { "benlubas/neorg-interim-ls" },
  keys = {
    {
      "<leader>nn",
      "<Plug>(neorg.dirman.new-note)",
      desc = "[neorg] New note",
    },
  },
  opts = {
    load = {
      ["core.completion"] = {
        config = {
          engine = { module_name = "external.lsp-completion" },
        },
      },
      ["core.concealer"] = {},
      ["core.defaults"] = {},
      ["core.dirman"] = {
        config = {
          workspaces = { notes = "~/neorg" },
          default_workspace = "notes",
          use_popup = false,
        },
      },
      ["core.esupports.metagen"] = {},
      ["core.export"] = {},
      ["core.itero"] = {},
      ["core.looking-glass"] = {},
      ["core.pivot"] = {},
      ["core.promo"] = {},
      ["core.qol.todo_items"] = {},
      ["core.summary"] = {},
      ["core.tangle"] = {},
      ["core.text-objects"] = {},
      ["external.interim-ls"] = {},
    },
  },
}
