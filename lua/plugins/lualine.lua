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
          cond = function()
            local buftype = vim.api.nvim_get_option_value("buftype", { buf = 0 })
            local exclude_buftypes = { "nofile", "prompt" }

            for _, ebuftype in ipairs(exclude_buftypes) do
              if buftype == ebuftype then
                return false
              end
            end

            return true
          end,
        },
      },
      lualine_x = {
        "filetype",
        {
          "encoding",
        },
        {
          "fileformat",
          icons_enabled = false,
          cond = function()
            return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt"
          end,
        },
      },
    },
  },
  init = function()
    vim.opt.showmode = false
    vim.opt.ruler = false -- Disable default ruler
  end,
}
