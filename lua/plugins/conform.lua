return {
  "stevearc/conform.nvim",
  version = "*",
  event = "BufWritePre",
  cmd = { "ConformInfo" },
  dependencies = {
    { "zapling/mason-conform.nvim", dependencies = "mason.nvim" },
  },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format()
      end,
      desc = "Format buffer",
    },
    {
      "<leader>f",
      function()
        local _, srow, scol = unpack(vim.fn.getpos("'<"))

        local _, erow, ecol = unpack(vim.fn.getpos("'>"))
        require("conform").format({
          async = false,
          range = { start = { srow, scol }, ["end"] = { erow, ecol } },
        })
      end,
      mode = "v",
      desc = "Format selection",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black", "isort" },
      markdown = { "prettier" },
      html = { "prettier" },
      javascript = { "prettier" },
    },
    notify_on_error = false,
    format_on_save = function(bufnr)
      if vim.g.autoformat == false or vim.b[bufnr].autoformat == false then
        return
      end
      return {
        timeout_ms = 500,
        lsp_format = "fallback",
      }
    end,
    default_format_opts = {
      lsp_format = "fallback",
      async = true,
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)
    require("mason-conform").setup()
  end,
}
