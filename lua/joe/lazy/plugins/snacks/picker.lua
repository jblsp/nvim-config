local pickers = {
  help = function()
    Snacks.picker.help()
  end,
  keymaps = function()
    Snacks.picker.keymaps({ layout = { preview = false } })
  end,
  files = function()
    Snacks.picker.files()
  end,
  grep = function()
    Snacks.picker.grep()
  end,
  grep_buffers = function()
    Snacks.picker.grep_buffers()
  end,
  grep_word = function()
    Snacks.picker.grep_word()
  end,
  buffers = function()
    Snacks.picker.buffers()
  end,
  lines = function()
    Snacks.picker.lines()
  end,
  config_files = function()
    Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
  end,
  spelling = function()
    Snacks.picker.spelling()
  end,
  undo = function()
    Snacks.picker.undo()
  end,
  colorschemes = function()
    Snacks.picker.colorschemes()
  end,
  lsp_nav = function()
    Snacks.picker.lsp_symbols({ layout = { preset = "vscode", preview = "main" } })
  end,
  git_branches = function()
    Snacks.picker.git_branches()
  end,
  directories = function()
    Snacks.picker.pick({
      title = "Directories",
      format = "text",
      finder = function(opts, ctx)
        local proc_opts = {
          cmd = "fd",
          args = { ".", "--type", "directory" },
        }
        return require("snacks.picker.source.proc").proc({ opts, proc_opts }, ctx)
      end,
      confirm = function(picker, item)
        picker:close()
        if item then
          vim.cmd("e " .. item.text)
        end
      end,
    })
  end,
}

return {
  "snacks.nvim",
  opts = {
    picker = {
      enabled = true,
      matcher = {
        smartcase = vim.opt.smartcase:get(),
        ignorecase = vim.opt.ignorecase:get(),
        frecency = true,
      },
      ui_select = true,
    },
  },
  -- stylua: ignore
  keys = {
    {"<leader>sp", function() Snacks.picker.pick({}) end, desc = "Search pickers",},
    {"<leader>sh", pickers.help, desc = "Search help",},
    {"<leader>sk", pickers.keymaps, desc = "Search keymaps"},
    {"<leader>sf", pickers.files,  desc = "Search files",},
    {"<leader>sgg", pickers.grep, desc = "Grep in cwd",},
    {"<leader>sgb", pickers.grep_buffers, desc = "Grep open buffers",},
    {"<leader>sw", pickers.grep_word, desc = "Grep visual selection or word", mode = { "n", "x" },},
    {"<leader>bs", pickers.buffers, desc = "Search buffers",},
    {"<leader>/", pickers.lines, desc = "Fuzzy find in current buffer",},
    {"<leader>sn",  pickers.config_files, desc = "Search config files",},
    {"z=", pickers.spelling,  desc = "Spelling suggestions",},
    {"<leader>u", pickers.undo, desc = "Undo history",},
    {"<leader>ld", function() Snacks.picker.lsp_definitions() end, desc = "LSP definitions",},
    {"<leader>lr", function() Snacks.picker.lsp_references() end, desc = "LSP references",},
    {"<leader>li", function() Snacks.picker.lsp_implementations() end, desc = "LSP implementations",},
    {"<leader>lD", function() Snacks.picker.lsp_declarations() end, desc = "LSP declarations",},
    {"<leader>lt", function() Snacks.picker.lsp_type_definitions() end, desc = "LSP type definitions",},
    {"<leader>lr", function() Snacks.picker.lsp_references() end, desc = "LSP references",},
    {"<leader>sc", pickers.colorschemes, desc = "Search colorschemes",},
    {"<leader>ls", pickers.lsp_nav, desc = "Navigate LSP symbols",},
    {"<leader>gB", pickers.git_branches, desc = "Git Branches",},
    {"<leader>sd", pickers.directories, desc = "Search directories" }
  },
}
