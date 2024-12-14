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
      "<leader>bD",
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
      "<leader>bW",
      function()
        Snacks.bufdelete.other({ wipe = true })
      end,
      desc = "Wipeout all other buffers",
    },
  },
}
