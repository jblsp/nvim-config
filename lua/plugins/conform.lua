return {
  "stevearc/conform.nvim",
  version = "*",
  event = "BufWritePre",
  cmd = { "ConformInfo" },
  init = function()
    vim.opt.formatexpr = [[v:lua.require'conform'.formatexpr()]]
  end,
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format()
        vim.cmd("w")
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
      typescript = { "prettierd" },
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
