local M = {}

local lsp_keymaps = {}

local function set_keymaps(mappings, event, desc_prepend)
  for _, mapping in ipairs(mappings) do
    local mode, lhs, rhs, opts, cond = unpack(mapping)
    if type(cond) ~= "function" or cond(event) then
      local modified_opts = vim.fn.copy(opts)
      modified_opts.buffer = event.buf
      modified_opts.desc = desc_prepend .. opts.desc
      vim.keymap.set(mode, lhs, rhs, modified_opts)
    end
  end
end

function M.lsp_map(mode, lhs, rhs, opts, cond)
  opts = opts or {}
  lsp_keymaps = vim.fn.insert(lsp_keymaps, { mode, lhs, rhs, opts, cond })
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-keymaps", { clear = true }),
  callback = function(event)
    set_keymaps(lsp_keymaps, event, "LSP: ")
  end,
})

return M
