return {
  "b0o/incline.nvim",
  event = "VeryLazy",
  opts = {
    hide = {
      only_win = true,
    },
    highlight = {
      groups = {
        InclineNormal = "StatusLine",
        InclineNormalNC = "StatusLineNC",
      },
    },
    window = {
      padding = 0,
      margin = { horizontal = 0 },
    },
    ignore = {
      buftypes = { "nofile" },
      unlisted_buffers = false,
    },
    render = function(props)
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
      local not_current = props.win ~= vim.api.nvim_get_current_win()

      if filename == "" then
        filename = "[No Name]"
      end

      return {
        {
          not_current and " " or "▍",
          guifg = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Special" }).fg),
        },
        { filename },
        { vim.bo[props.buf].modified and " ●" or "" },
        { vim.bo[props.buf].ro and " ⊘" or "" },
        { " " },
      }
    end,
  },
}
