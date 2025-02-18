return {
  "snacks.nvim",
  keys = {
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete current buffer",
    },
    {
      "<leader>bo",
      function()
        Snacks.bufdelete.other()
      end,
      desc = "Delete all other buffers",
    },
    {
      "<leader>bw",
      function()
        Snacks.bufdelete({ wipe = true })
      end,
      desc = "Wipeout current buffer",
    },
    {
      "<leader>bO",
      function()
        Snacks.bufdelete.other({ wipe = true })
      end,
      desc = "Wipeout all other buffers",
    },
  },
}
