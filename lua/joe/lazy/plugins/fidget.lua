return {
  "j-hui/fidget.nvim",
  event = "VeryLazy",
  version = "*",
  opts = {
    progress = {
      display = {
        done_icon = "󰸞",
        done_ttl = 5,
      },
    },
    notification = {
      poll_rate = 50,
      override_vim_notify = true,
      window = {
        winblend = 45,
      },
    },
  },
  config = function(_, opts)
    opts = vim.tbl_deep_extend(
      "force",
      opts,
      { notification = { configs = { default = require("fidget.notification").default_config } } }
    )
    opts.notification.configs.default.name = nil
    opts.notification.configs.default.icon = nil

    require("fidget").setup(opts)
  end,
}
