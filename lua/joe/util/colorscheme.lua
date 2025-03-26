local M = {}

-- adapted from lazy.nvim source
local function get_name(url)
  local name = url

  name = name:sub(-4) == ".git" and name:sub(1, -5) or name
  name = name:sub(-5) == ".nvim" and name:sub(1, -6) or name

  local slash = name:reverse():find("/", 1, true)

  if slash then
    local repo_name = name:sub(#name - slash + 2)

    -- if the repo name is in this list, then take the org name instead
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

  local lazy_spec = {
    [1] = short_url,
    main = clrs_spec.name,
    name = "colorschemes." .. clrs_spec.name,
    priority = 1000,
    lazy = true,
    opts = clrs_spec.opts or clrs_spec.setup ~= false and {},
  }

  return lazy_spec
end

return M
