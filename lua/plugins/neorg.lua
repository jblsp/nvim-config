return {
  "nvim-neorg/neorg",
  version = "*",
  ft = "norg",
  cmd = "Neorg",
  keys = {
    {
      "<leader>nn",
      "<Plug>(neorg.dirman.new-note)",
    },
  },
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.concealer"] = {},
      ["core.dirman"] = {
        config = {
          workspaces = {
            notes = "~/neorg",
          },
          default_workspace = "neorg",
        },
      },
    },
  },
}
