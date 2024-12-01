return {
  "j-hui/fidget.nvim",
  event = "VeryLazy",
  opts = {
    progress = {
      display = {
        done_icon = "󰸞",
        done_ttl = 5,
      },
    },
    notification = {
      override_vim_notify = true,
      window = {
        winblend = 45,
      },
    },
  },
}
