return {
  "lukas-reineke/indent-blankline.nvim",
  version = "*",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  opts = {
    indent = { char = "▎", priority = 2 },
    scope = { show_start = false, show_end = false },
    exclude = {
      filetypes = {
        "markdown",
        "text",
      },
    },
  },
}
