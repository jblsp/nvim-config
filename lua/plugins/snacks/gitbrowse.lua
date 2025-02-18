return {
  "snacks.nvim",
  keys = {
    {
      "<leader>gx",
     function()
        Snacks.gitbrowse()
      end,
      desc = "Open current repo in browser",
    },
  },
}
