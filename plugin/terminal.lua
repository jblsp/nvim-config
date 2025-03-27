vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Set terminal local opts",
  group = vim.api.nvim_create_augroup("set-term-mode-opts", { clear = true }),
  callback = function()
    if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "terminal" then
      vim.cmd("startinsert")
      vim.bo.filetype = "terminal"

      local opt = vim.opt_local
      opt.scrolloff = 0
    end
  end,
})
