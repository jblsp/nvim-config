return {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    render = "virtual",
    virtual_symbol = "●",
    -- virtual_symbol_suffix = "",
    -- virtual_symbol_prefix = " ",
    -- virtual_symbol_position = "eow",
    enabled_named_colors = false,
    exclude_buftypes = { "nofile" },
  },
}
