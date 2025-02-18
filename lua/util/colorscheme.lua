local M = {}

-- adapted from lazy.nvim source
local function get_name(url)
  local name = url

  name = name:sub(-4) == ".git" and name:sub(1, -5) or name
  name = name:sub(-5) == ".nvim" and name:sub(1, -6) or name

  local slash = name:reverse():find("/", 1, true)

  if slash then
    local repo_name = name:sub(#name - slash + 2)

    -- if the repo name is in this list, then we take the org name instead
    local org_names = { "nvim", "neovim" }
    if vim.tbl_contains(org_names, repo_name) then
      return name:sub(1, #name - slash)
    else
      return repo_name
    end
  else
    return url:gsub("%W+", "_")
  end
end

function M.lazy_spec(short_url, clrs_spec)
  clrs_spec = clrs_spec or {}

  if not clrs_spec.name then
    clrs_spec["name"] = get_name(short_url)
  end

  local active = clrs_spec.name == vim.g.colorscheme

  local lazy_spec = {
    [1] = short_url,
    main = clrs_spec.name,
    name = "colorschemes." .. clrs_spec.name,
    priority = 1000,
    lazy = not active,
    pin = not active,
    opts = clrs_spec.opts or clrs_spec.setup ~= false and {},
  }

  if active then
    lazy_spec["config"] = function()
      vim.cmd.colorscheme(clrs_spec.style or vim.g.colorscheme)
    end
  end

  return lazy_spec
end

return M
