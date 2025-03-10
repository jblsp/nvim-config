return {
  "stevearc/conform.nvim",
  version = "*",
  event = "BufWritePre",
  cmd = { "ConformInfo" },
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
      css = { "prettier" },
      html = { "prettier" },
      java = { lsp_format = "fallback" },
      javascript = { "prettier" },
      json = { "prettier" },
      lua = { "stylua" },
      markdown = { "prettier" },
      nix = { "alejandra" },
      python = { "black", "isort" },
      typescript = { "prettier" },
      cpp = { "clang-format" },
      c = { "clang-format" },
    },
    notify_on_error = true,
    notify_no_formatter = true,
    default_format_opts = {
      lsp_format = "never",
      async = true,
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)
    vim.opt.formatexpr = [[v:lua.require'conform'.formatexpr()]]
  end,
}
