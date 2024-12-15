return {
  "snacks.nvim",
  opts = {
    input = { icon = "", prompt_pos = "left", icon_pos = "left", expand = false },
    styles = {
      input = {
        border = "none",
        row = -3,
        width = 0,
        wo = { winhighlight = "NormalFloat:StatusLine" },
        keys = {
          esc = { "<esc>", { "cmp_close", "cancel" } },
          cr = { "<cr>", { "cmp_accept", "confirm" } },
          i_esc = { "<esc>", "stopinsert", mode = "i" },
          i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = "i" },
          i_tab = { "<tab>", { "cmp_select_next", "cmp" }, mode = "i" },
        },
      },
    },
  },
}
