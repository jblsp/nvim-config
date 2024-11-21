return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "rshkarin/mason-nvim-lint" },
  config = function()
    local lint = require("lint")

    local linters = {
      selene = {
        filetypes = { "lua" },
        config_files = { "selene.toml" },
        -- config = { args = { "-ex" } },
      },
      pylint = {
        filetypes = { "python" },
        config_files = { ".pylintrc" },
      },
    }

    local linters_by_ft = {}
    for name, linter in pairs(linters) do
      -- Add linter configuration
      if linter.config then
        lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter.config)
      end

      -- Add linter to linters_by_ft
      for _, ftype in ipairs(linter.filetypes) do
        linters_by_ft[ftype] = linters_by_ft[ftype] or {}
        table.insert(linters_by_ft[ftype], name)
      end
    end

    lint.linters_by_ft = linters_by_ft

    require("mason-nvim-lint").setup() -- Install missing linters

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave", "CursorHoldI" }, {
      group = lint_augroup,
      callback = function()
        if not vim.opt_local.modifiable:get() then
          return
        end

        -- Lint only when config file is present
        local linter_names = lint._resolve_linter_by_ft(vim.bo.filetype)
        linter_names = vim.tbl_filter(function(name)
          return vim.fs.find(linters[name].config_files, { path = vim.api.nvim_buf_get_name(0), upward = true })[1]
        end, linter_names)

        require("lint").try_lint(linter_names)
      end,
    })
  end,
}
