return {
  "neovim/nvim-lspconfig",
  version = "*",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = {
    {
      "williamboman/mason-lspconfig.nvim",
      version = "*",
      dependencies = { "mason.nvim" },
    },
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

    local mason_lsps = {
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
    }

    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_keys(mason_lsps or {}),
      handlers = {
        function(server_name)
          local server = mason_lsps[server_name]
          -- Only configures servers in the mason_lsps table
          if server then
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end
        end,
      },
    })
  end,
}
