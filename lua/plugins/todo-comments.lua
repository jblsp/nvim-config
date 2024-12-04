return {
  "folke/todo-comments.nvim",
  version = "*",
  event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  opts = {
    signs = false,
  },
  keys = {
    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next todo comment",
    },
    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous todo comment",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
