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
    {"<leader>sh", function() Snacks.picker.help() end, desc = "Search help",},
    {"<leader>sk", function() Snacks.picker.keymaps({ layout = { preview = false } }) end, desc = "Search keymaps",},
    {"<leader>sf", function() Snacks.picker.files() end, desc = "Search files",},
    {"<leader>sp", function() Snacks.picker.pickers() end, desc = "Search Snacks.picker sources",},
    {"<leader>sgg", function() Snacks.picker.grep() end, desc = "Grep",},
    {"<leader>sgb", function() Snacks.picker.pickers() end, desc = "Grep open buffers",},
    {"<leader>sw", function() Snacks.picker.grep_word() end, desc = "Grep visual selection or word", mode = { "n", "x" },},
    {"<leader>bs", function() Snacks.picker.buffers() end, desc = "Search buffers",},
    {"<leader>/", function() Snacks.picker.lines() end, desc = "Fuzzy find in current buffer",},
    {"<leader>sn", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Search Neovim config",},
    {"z=", function() Snacks.picker.spelling() end, desc = "Spelling suggestions",},
    {"<leader>u", function() Snacks.picker.undo() end, desc = "Undo history",},
    {"<leader>ld", function() Snacks.picker.lsp_definitions() end, desc = "LSP definitions",},
    {"<leader>lr", function() Snacks.picker.lsp_references() end, desc = "LSP references",},
    {"<leader>li", function() Snacks.picker.lsp_implementations() end, desc = "LSP implementations",},
    {"<leader>lD", function() Snacks.picker.lsp_declarations() end, desc = "LSP declarations",},
    {"<leader>lt", function() Snacks.picker.lsp_type_definitions() end, desc = "LSP type definitions",},
    {"<leader>lr", function() Snacks.picker.lsp_references() end, desc = "LSP references",},
    {"<leader>sc", function() Snacks.picker.colorschemes() end, desc = "Search colorschemes",},
    {"<leader>ch", function() Snacks.picker.cliphist() end, desc = "Search clipboard history",},
    {"<leader>ls", function() Snacks.picker.lsp_symbols({ layout = { preset = "vscode", preview = "main" } }) end, desc = "Navigate LSP symbols",},
    {"<leader>gB", function() Snacks.picker.git_branches() end, desc = "Git Branches",},
  },
}
