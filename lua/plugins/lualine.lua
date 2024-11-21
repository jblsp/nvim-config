return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      component_separators = "",
      section_separators = "",
    },
    sections = {
      lualine_a = {
        {
          "mode",
          fmt = function(str)
            return str:sub(1, 1)
          end,
        },
      },
      lualine_b = {
        "branch",
        "diff",
        {
          "diagnostics",
          cond = function()
            return vim.diagnostic.is_enabled()
          end,
        },
      },
      lualine_c = {
        {
          "filename",
          symbols = {
            modified = "●",
            readonly = "⊘",
          },
          cond = function()
            local buftype = vim.api.nvim_get_option_value("buftype", { buf = 0 })
            local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
            local exclude_buftypes = { "nofile" }
            local exclude_filetypes = { "TelescopePrompt" }

            for _, ebuftype in ipairs(exclude_buftypes) do
              if buftype == ebuftype then
                return false
              end
            end

            for _, efiletype in ipairs(exclude_filetypes) do
              if efiletype == filetype then
                return false
              end
            end

            return true
          end,
        },
      },
      lualine_x = { "encoding", { "fileformat", icons_enabled = false }, "filetype" },
    },
  },
  init = function()
    vim.opt.showmode = false
    vim.opt.ruler = false -- Disable default ruler
  end,
}
