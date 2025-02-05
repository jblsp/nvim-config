return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  init = function()
    vim.opt.showmode = false
  end,
  opts = {
    options = {
      component_separators = "",
      section_separators = "",
      refresh = {
        statusline = 50,
        winbar = 50,
      },
      globalstatus = vim.opt.laststatus:get() == 3,
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
      },
      lualine_c = {
        { "filename", path = 1 },
        {
          "diagnostics",
          cond = function()
            return vim.diagnostic.is_enabled()
          end,
        },
      },
      lualine_x = {
        {
          "encoding",
          fmt = function(s)
            return string.upper(s)
          end,
        },
        {
          "fileformat",
          symbols = {
            unix = "LF",
            dos = "CRLF",
            mac = "CR",
          },
        },
      },
      lualine_y = { "filetype" },
      lualine_z = {
        {
          "location",
          fmt = function(s)
            return string.gsub(s, "%s+", "")
          end,
        },
        "progress",
      },
    },
    inactive_sections = {
      lualine_c = { { "filename", path = 1 } },
    },
  },
}
