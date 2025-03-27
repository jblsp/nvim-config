vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Auto create directory when saving a file",
  group = vim.api.nvim_create_augroup("auto-create-dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then -- ignore remote files
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    local parent = vim.fn.fnamemodify(file, ":p:h")
    if vim.fn.isdirectory(parent) == 0 then
      if
        vim.fn.confirm("Directory " .. parent .. " does not exist. Would you like to create it?", "&Yes\n&No") == 1
      then
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
      end
    end
  end,
})
