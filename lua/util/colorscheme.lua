local M = {}

function M.create_spec(short_url, name, opts)
  local spec = {
    [1] = short_url,
    main = name,
    name = "colorschemes-" .. name,
    priority = 1000,
    lazy = not (name == vim.g.colorscheme),
    opts = opts or {},
  }
  return spec
end

return M
