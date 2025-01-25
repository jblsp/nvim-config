return {
  "mfussenegger/nvim-lint",
  enabled = false,
  event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  config = function()
    local lint = require("lint")

    -- if the config_files field is present,
    -- the linter will only run when one of the specified config files is present
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
      ["markdownlint-cli2"] = {
        filetypes = { "markdown" },
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

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave", "CursorHoldI" }, {
      group = lint_augroup,
      callback = function()
        if not vim.opt_local.modifiable:get() then
          return
        end

        local linter_names = lint._resolve_linter_by_ft(vim.bo.filetype)
        linter_names = vim.tbl_filter(function(name)
          -- Lint only when config file is present
          local cfg_files = linters[name].config_files
          if cfg_files then
            if not vim.fs.find(cfg_files, { path = vim.api.nvim_buf_get_name(0), upward = true })[1] then
              return false
            end
          end

          return true
        end, linter_names)

        require("lint").try_lint(linter_names)
      end,
    })
  end,
}
