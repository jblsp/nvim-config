return {
  "nvim-lualine/lualine.nvim",
  enabled = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  priority = 999,
  init = function()
    vim.opt.showmode = false
  end,
  opts = function()
    local ccs = {
      filepath = {
        "filename",
        path = 1,
      },
      fileformat = { "fileformat", symbols = { unix = "LF", dos = "CRLF", mac = "CR" } },
      encoding = {
        "encoding",
        fmt = function(s)
          return string.upper(s)
        end,
      },
      diagnostics = {
        "diagnostics",
        cond = function()
          return vim.diagnostic.is_enabled()
        end,
      },
      mode = {
        "mode",
        fmt = function(str)
          return str:sub(1, 1)
        end,
      },
      tabs = {
        "tabs",
        mode = 2,
        show_modified_status = false,
      },
    }

    local statusline = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = {},
      lualine_x = { "location", "progress" },
      lualine_y = {},
      lualine_z = {},
    }

    local winbar = {
      lualine_c = { "filename", ccs.diagnostics, "diff" },
      lualine_x = { ccs.encoding, ccs.fileformat, "filetype" },
    }

    return {
      options = {
        theme = "auto",
        component_separators = "",
        section_separators = "",
        refresh = {
          statusline = 50,
          tabline = 50,
          winbar = 50,
        },
        globalstatus = vim.opt.laststatus:get() == 3,
      },
      sections = statusline,
      winbar = winbar,
      inactive_winbar = winbar,
    }
  end,
}
