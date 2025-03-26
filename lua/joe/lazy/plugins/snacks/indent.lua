return {
  "snacks.nvim",
  opts = {
    indent = {
      indent = {
        char = "▎",
      },
      scope = {
        char = "▎",
        only_current = true,
      },
      animate = {
        enabled = false,
      },
      filter = function(buf)
        local exclude_filetypes = { "text", "markdown", "norg" }
        local ok_filetype =
          not vim.tbl_contains(exclude_filetypes, vim.api.nvim_get_option_value("filetype", { buf = buf }))
        return ok_filetype and vim.bo[buf].buftype == ""
      end,
    },
  },
}
