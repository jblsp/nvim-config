return {
  "snacks.nvim",
  keys = {
    {
      "<leader>gx",
     function()
        Snacks.gitbrowse()
      end,
      desc = "Open current git repo in browser",
    },
  },
}
