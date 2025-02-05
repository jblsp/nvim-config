return {
  "stevearc/oil.nvim",
  version = "*",
  lazy = false,
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  keys = {
    {
      "<leader>E",
      function()
        require("oil").open(vim.uv.cwd())
      end,
      desc = "Open oil.nvim at cwd",
    },
    {
      "<leader>e",
      function()
        require("oil").open()
      end,
      desc = "Open oil.nvim at directory of current file",
    },
  },
  opts = {
    default_file_explorer = true,
    keymaps = {
      ["<esc>"] = {
        "actions.close",
        mode = "n",
      },
    },
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name, _)
        local always_hidden = { ".DS_Store" }
        return vim.tbl_contains(always_hidden, name)
      end,
    },
  },
}
