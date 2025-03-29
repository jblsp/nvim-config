-- Modified from Snacks.bufdelete: https://github.com/folke/snacks.nvim/

local M = {}

--- Delete a buffer without changing window layout
---@param opts? { buf?: integer, wipe?: boolean, force?: boolean }
function M.delete(opts)
  opts = opts or {}

  local buf = opts.buf or vim.api.nvim_get_current_buf()

  vim.api.nvim_buf_call(buf, function()
    if vim.bo.modified and not opts.force then
      local ok, choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
      local choices = { INTERRUPT = 0, YES = 1, NO = 2, CANCEL = 3 }
      if not ok or choice == choices.INTERRUPT or choice == choices.CANCEL then
        return
      end
      if choice == choices.YES then
        vim.cmd.write()
      end
    end

    for _, win in ipairs(vim.fn.win_findbuf(buf)) do
      vim.api.nvim_win_call(win, function()
        if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
          return
        end
        -- Try using alternate buffer
        local alt = vim.fn.bufnr("#")
        if alt ~= buf and vim.fn.buflisted(alt) == 1 then
          vim.api.nvim_win_set_buf(win, alt)
          return
        end

        -- Try using previous buffer
        local has_previous = vim.cmd("bprevious")
        if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
          return
        end

        -- Create new listed buffer
        local new_buf = vim.api.nvim_create_buf(true, false)
        vim.api.nvim_win_set_buf(win, new_buf)
      end)
    end
    if vim.api.nvim_buf_is_valid(buf) then
      vim.cmd((opts.wipe and "bwipeout! " or "bdelete! ") .. buf)
    end
  end)
end

---@param opts? { buf?: integer, wipe?: boolean, force?: boolean }
function M.other(opts)
  opts = opts or {}

  local cbuf = opts.buf or vim.api.nvim_get_current_buf()
  local bufs = vim.api.nvim_list_bufs()

  for _, buf in ipairs(bufs) do
    if buf ~= cbuf then
      M.delete({ buf = buf, wipe = opts.wipe, force = opts.force })
    end
  end
end

return M
