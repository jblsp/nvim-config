local autocmd = util.autocmd

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Restore cursor to position from last edit",
  group = autocmd.group("cursor-restore"),
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.cmd('normal! g`"zz')
    end
  end,
})
