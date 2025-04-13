local lsp = vim.lsp

lsp.config("*", {
  root_markers = { ".git" },
})
lsp.enable({
  "basedpyright",
  "bashls",
  "clangd",
  "lua_ls",
  "marksman",
  "ts_ls",
})
