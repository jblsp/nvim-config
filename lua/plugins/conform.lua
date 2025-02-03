return {
  "stevearc/conform.nvim",
  version = "*",
  event = "BufWritePre",
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        if require("conform").format() then
          vim.cmd("w")
        end
      end,
      desc = "Format and write buffer",
    },
    {
      "<leader>F",
      function()
        require("conform").format()
      end,
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black", "isort" },
      markdown = { "prettierd" },
      html = { "prettierd" },
      javascript = { "prettierd" },
      nix = { "alejandra" },
      java = { lsp_format = "fallback" },
    },
    notify_on_error = true,
    notify_no_formatter = true,
    default_format_opts = {
      lsp_format = "never",
      async = true,
    },
  },
}
