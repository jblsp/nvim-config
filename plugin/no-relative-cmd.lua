local autocmd = util.autocmd

local augroup = autocmd.group("cmdlinenrs")
local cmdline_debounce_timer

autocmd.create("CmdlineEnter", {
  desc = "Disable relative line numbers in command mode",
  group = augroup,
  callback = function()
    cmdline_debounce_timer = vim.uv.new_timer()
    cmdline_debounce_timer:start(
      5,
      0,
      vim.schedule_wrap(function()
        if vim.o.number then
          vim.o.relativenumber = false
          vim.api.nvim__redraw({ statuscolumn = true })
        end
      end)
    )
  end,
})

autocmd.create("CmdlineLeave", {
  group = augroup,
  callback = function()
    if cmdline_debounce_timer then
      cmdline_debounce_timer:stop()
      cmdline_debounce_timer = nil
    end
    if vim.o.number then
      vim.o.relativenumber = true
    end
  end,
})
