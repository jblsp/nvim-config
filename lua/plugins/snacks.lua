return {
  "folke/snacks.nvim",
  version = "*",
  priority = 1000,
  lazy = false,
  opts = {
    statuscolumn = {
      enabled = true,
    },
    words = {
      enabled = true,
    },
    bigfile = {
      enabled = true,
      size = 5 * 1024 * 1024, -- 5MB
    },
    quickfile = { enabled = true },
  },
  keys = {
    {
      "<leader>rf",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },
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
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Git Browse",
    },
  },
  init = function()
    local augroup = vim.api.nvim_create_augroup("Snacks", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      group = augroup,
      callback = function()
        vim.print = Snacks.debug.inspect

        -- mini.files integration
        vim.api.nvim_create_autocmd("User", {
          pattern = "MiniFilesActionRename",
          group = augroup,
          callback = function(event)
            Snacks.rename.on_rename_file(event.data.from, event.data.to)
          end,
        })
      end,
    })
  end,
}
