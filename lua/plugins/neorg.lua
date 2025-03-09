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
      ["core.clipboard.code-blocks"] = {},
      ["core.esupports.hop"] = {},
      ["core.esupports.indent"] = {},
      ["core.esupports.metagen"] = { config = {
        author = "Joe",
        type = "auto",
      } },
      ["core.itero"] = {},
      ["core.journal"] = {},
      ["core.keybinds"] = {},
      ["core.looking-glass"] = {},
      ["core.pivot"] = {},
      ["core.promo"] = {},
      ["core.qol.toc"] = {},
      ["core.qol.todo_items"] = {},
      ["core.tangle"] = {},
      ["core.todo-introspector"] = {},
      ["core.ui.calendar"] = {},
      ["core.completion"] = { config = {
        engine = { module_name = "external.lsp-completion" },
      } },
      ["core.concealer"] = {},
      ["core.dirman"] = {
        config = {
          workspaces = { notes = "~/neorg" },
          default_workspace = "notes",
          use_popup = false,
        },
      },
      ["core.export"] = {},
      ["core.summary"] = {},
      ["core.text-objects"] = {},
      ["external.interim-ls"] = {},
    },
  },
}
