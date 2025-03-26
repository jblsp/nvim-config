local in_git_project = require("joe.util.fn").in_git_project

return {
  "rmagatti/auto-session",
  version = false, -- the latest release v2.5.0 is missing some features i'm using
  lazy = false,
  init = function()
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
  end,
  keys = {
    {
      "<leader>ss",
      "<cmd>SessionSearch<cr>",
      desc = "Search Sessions",
    },
  },
  opts = {
    auto_restore = false,
    auto_create = in_git_project,
    use_git_branch = true,
    suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    bypass_save_filetypes = { "dashboard", "alpha", "netrw", "minifiles" },
    session_lens = {
      load_on_setup = false,
      previewer = false, -- telescope previewer
      theme_conf = {
        preview = false, -- snacks previewer
      },
      mappings = {
        copy_session = { { "n", "i" }, "<C-Y>" },
      },
    },
    pre_restore_cmds = {
      function()
        vim.api.nvim_exec_autocmds("User", { pattern = "SessionLoadPre" })
      end,
    },
  },
}
