return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "bwpge/lualine-pretty-path", "nvim-tree/nvim-web-devicons" },
  lazy = false,
  init = function()
    vim.opt.showmode = false
  end,
  opts = {
    options = {
      component_separators = "",
      section_separators = "",
      refresh = {
        statusline = 35,
        winbar = 35,
      },
    },
    sections = {
      lualine_a = {
        {
          "mode",
          -- fmt = function(str)
          --   return str:sub(1, 1)
          -- end,
        },
      },
      lualine_b = {
        "branch",
        "diff",
      },
      lualine_c = {
        {
          "pretty_path",
          icon_show = false,
          symbols = {
            modified = "[+]",
            readonly = "[-]",
          },
          directories = {
            max_depth = 4,
          },
          highlights = {
            directory = "NonText",
            filename = "",
            modified = "",
          },
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
        {
          "diagnostics",
          cond = function()
            return vim.diagnostic.is_enabled()
          end,
        },
      },
      lualine_x = { "filetype" },
      lualine_y = {
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
          cond = function()
            return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt"
          end,
        },
      },
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
  },
}
