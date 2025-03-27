local augroup = vim.api.nvim_create_augroup("cmdlinenrs", { clear = true })
local cmdline_debounce_timer

vim.api.nvim_create_autocmd("CmdlineEnter", {
  desc = "Disable relative line numbers in command mode",
  group = augroup,
  callback = function()
    cmdline_debounce_timer = vim.uv.new_timer()
    if cmdline_debounce_timer then
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
    end
  end,
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
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
