local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local group

autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd("VimEnter", {
  desc = 'Remove "How to disable mouse" tip from context menu',
  group = augroup("remove-disable-mouse-tip", { clear = true }),
  callback = function()
    vim.cmd([[aunmenu PopUp.How-to\ disable\ mouse]])
    vim.cmd([[aunmenu PopUp.-1-]])
  end,
})

autocmd("DirChanged", {
  desc = "Send notification on dir change",
  group = augroup("dir-change-notif", { clear = true }),
  callback = function(args)
    vim.notify("cwd set to " .. args.file, vim.log.levels.INFO, { title = "cwd" })
  end,
})

group = augroup("CmdlineLinenr", { clear = true })
local cmdline_debounce_timer
autocmd("CmdlineEnter", {
  group = group,
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
  group = group,
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

group = augroup("auto-delete-blank-buffers", { clear = true })
autocmd({ "VimEnter", "SessionLoadPost" }, {
  group = group,
  callback = function()
    autocmd("BufEnter", {
      desc = "Delete previous buffer if empty",
      group = group,
      callback = function()
        local prev_buf = vim.fn.bufnr("#")
        if prev_buf ~= -1 then
          if util.fn.is_buf_empty(prev_buf) and not util.fn.is_buf_active(prev_buf) then
            vim.api.nvim_buf_delete(prev_buf, { force = true })
          end
        end
      end,
    })
    autocmd("WinClosed", {
      desc = "Delete empty buffer in closed window if inactive",
      group = group,
      callback = function(args)
        local win = tonumber(args.match)
        if args.buf == -1 then
          return
        end
        if util.fn.is_buf_empty(args.buf) and not util.fn.is_buf_active(args.buf, { win }) then
          vim.api.nvim_buf_delete(args.buf, { force = true })
        end
      end,
    })
  end,
})
autocmd("User", {
  pattern = { "SessionLoadPre", "PersistenceLoadPre" },
  group = group,
  callback = function()
    vim.api.nvim_clear_autocmds({ group = augroup })
  end,
})
