local M = {}

local bufdelete = require("joe.util.bufdelete")

function M.bdelete()
  bufdelete.delete()
end

function M.bwipeout()
  bufdelete.delete({ wipe = true })
end

function M.bdelete_other()
  bufdelete.other()
end

function M.bwipeout_other()
  bufdelete.other({ wipe = true })
end

function M.anon_to_clip()
  local content = vim.fn.getreg('"')
  if content ~= "" then
    if vim.fn.setreg("+", content) == 0 then
      local _, lines = content:gsub("\n", "\n")
      local out = string.format("%d line(s) copied to clipboard", lines)
      vim.api.nvim_echo({ { out } }, true, {})
    end
  end
end

return M
