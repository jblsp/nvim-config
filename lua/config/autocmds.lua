vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  desc = 'Remove "How to disable mouse" tip from context menu',
  group = vim.api.nvim_create_augroup("remove-disable-mouse-tip", { clear = true }),
  callback = function()
    vim.cmd([[aunmenu PopUp.How-to\ disable\ mouse]])
    vim.cmd([[aunmenu PopUp.-1-]])
  end,
})

vim.api.nvim_create_autocmd("DirChanged", {
  desc = "Send notification on dir change",
  group = vim.api.nvim_create_augroup("dir-change-notif", { clear = true }),
  callback = function(args)
    vim.notify("cwd set to " .. args.file, vim.log.levels.INFO, { title = "cwd" })
  end,
})

local auto_blank_bd_augroup = vim.api.nvim_create_augroup("auto-delete-blank-buffers", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "SessionLoadPost" }, {
  group = auto_blank_bd_augroup,
  callback = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      desc = "Delete previous buffer if empty",
      group = auto_blank_bd_augroup,
      callback = function()
        local prev_buf = vim.fn.bufnr("#")
        if prev_buf ~= -1 then
          if util.is_buf_empty(prev_buf) and not util.is_buf_active(prev_buf) then
            vim.api.nvim_buf_delete(prev_buf, { force = true })
          end
        end
      end,
    })
    vim.api.nvim_create_autocmd("WinClosed", {
      desc = "Delete empty buffer in closed window if inactive",
      group = auto_blank_bd_augroup,
      callback = function(args)
        local win = tonumber(args.match)
        if args.buf == -1 then
          return
        end
        if util.is_buf_empty(args.buf) and not util.is_buf_active(args.buf, { win }) then
          vim.api.nvim_buf_delete(args.buf, { force = true })
        end
      end,
    })
  end,
})
vim.api.nvim_create_autocmd("User", {
  pattern = "SessionLoadPre",
  group = auto_blank_bd_augroup,
  callback = function()
    vim.api.nvim_clear_autocmds({ group = auto_blank_bd_augroup })
  end,
})
