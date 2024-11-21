return {
  "williamboman/mason.nvim",

  event = "VeryLazy",
  opts = {
    ui = {
      icons = {
        package_installed = "●",
        package_pending = "◍",
        package_uninstalled = "○",
      },
    },
  },
}
