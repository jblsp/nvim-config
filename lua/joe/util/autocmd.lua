local M = {}

M.create = vim.api.nvim_create_autocmd

function M.group(name, opts)
  opts = opts or { clear = true }
  return vim.api.nvim_create_augroup(name, opts)
end

return M
