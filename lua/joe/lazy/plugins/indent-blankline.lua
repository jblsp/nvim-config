return {
  "lukas-reineke/indent-blankline.nvim",
  version = "*",
  lazy = false,
  main = "ibl",
  opts = {
    indent = { char = "▎", tab_char = "▎" },
    scope = { show_start = false, show_end = false },
    debounce = 50,
    exclude = {
      filetypes = {
        "markdown",
        "text",
      },
    },
  },
}
