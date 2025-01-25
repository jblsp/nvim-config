return {
  "neovim/nvim-lspconfig",
  version = "*",
  event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  config = function()
    local capabilities = util.lsp_capabilities.get()

    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },
      pyright = {},
      nixd = {},
      hls = {},
    }

    for server_name, config in pairs(servers) do
      config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
      require("lspconfig")[server_name].setup(config)
    end
  end,
}
