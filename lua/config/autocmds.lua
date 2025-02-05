local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = augroup("highlight-yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd("DirChanged", {
  desc = "Send notification on dir change",
  group = augroup("dir-change-notif"),
  callback = function(args)
    vim.notify("cwd set to " .. args.file, vim.log.levels.INFO, { title = "cwd" })
  end,
})

local cmdlinenrs_group = augroup("cmdlinenrs")
local cmdline_debounce_timer
autocmd("CmdlineEnter", {
  desc = "Disable relative line numbers in command mode",
  group = cmdlinenrs_group,
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
autocmd("CmdlineLeave", {
  desc = "Enable relative line numbers (if enabled)",
  group = cmdlinenrs_group,
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

autocmd("BufWritePre", {
  desc = "Auto create directory when saving a file",
  group = augroup("auto-create-dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then -- ignore remote files
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    local parent = vim.fn.fnamemodify(file, ":p:h")
    if vim.fn.isdirectory(parent) == 0 then
      if vim.fn.confirm("Directory " .. parent .. " does not exist. Would you like to create it?", "&Yes\n&No") == 1 then
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
      end
    end
  end,
})
