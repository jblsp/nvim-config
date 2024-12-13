local M = {}

local mods = {}

function M.get()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  for _, mod in ipairs(mods) do
    capabilities = mod(capabilities)
  end
  return capabilities
end

function M.modify(callback)
  table.insert(mods, callback)
end

return M
