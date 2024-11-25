local M = {}

function M.create_spec(short_url, name, opts)
  local spec = {
    [1] = short_url,
    name = name,
    priority = 1000,
    lazy = not (name == vim.g.colorscheme),
    opts = opts or {},
  }
  return spec
end

return { colorscheme = M }
