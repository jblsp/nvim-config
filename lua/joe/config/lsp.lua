-- Global LSP Configuration
vim.lsp.config("*", {
  root_markers = { ".git" },
})

-- Enabled language servers
vim.lsp.enable({
  "lua_ls",
  "pyright",
})
