return {
  "folke/which-key.nvim",
  dependencies = {
    { "mini.icons", opts = {} },
  },
  version = "*",
  event = "VeryLazy",
  opts = {
    delay = 350,
    plugins = {
      spelling = {
        enabled = false,
      },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = true })
      end,
      desc = "Show local keymaps",
      mode = { "n", "v" },
    },
  },
}
