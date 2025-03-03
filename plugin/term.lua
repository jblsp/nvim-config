local autocmd = util.autocmd

autocmd.create("TermOpen", {
  desc = "Set terminal local opts",
  group = autocmd.group("set-term-mode-opts"),
  callback = function()
    if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "terminal" then
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.signcolumn = "no"
      vim.opt_local.scrolloff = 0
      vim.bo.filetype = "terminal"
    end
  end,
})
