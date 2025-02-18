return {
  "lewis6991/gitsigns.nvim",
  version = "*",
  event = "VeryLazy",
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.buffer = bufnr
        if opts.desc ~= nil then
          opts.desc = "Git: " .. opts.desc
        end
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      map("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]h", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, { desc = "Next hunk" })

      map("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, { desc = "Previous hunk" })

      map("n", "<leader>ga", gitsigns.stage_hunk, { desc = "Stage hunk" })
      map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Reset hunk" })
      map("v", "<leader>ga", function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Stage hunk" })
      map("v", "<leader>gr", function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Reset hunk" })
      map("n", "<leader>gA", gitsigns.stage_buffer, { desc = "Stage buffer" })
      map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Reset buffer" })
      map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview hunk" })
      map("n", "<leader>gb", function()
        gitsigns.blame_line({ full = true })
      end, { desc = "Blame line" })
      map("n", "<leader>gd", gitsigns.diffthis, { desc = "Vimdiff current file" })
    end,
  },
}
