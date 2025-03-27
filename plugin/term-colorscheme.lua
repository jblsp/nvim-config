local augroup = vim.api.nvim_create_augroup("correct-terminal-colors", { clear = true })
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
  -- see: https://www.reddit.com/r/neovim/comments/1ehidxy/you_can_remove_padding_around_neovim_instance/"
  desc = "Corrects terminal background color according to colorscheme",
  group = augroup,
  callback = function()
    if vim.api.nvim_get_hl(0, { name = "Normal" }).bg then
      io.write(string.format("\027]11;#%06x\027\\", vim.api.nvim_get_hl(0, { name = "Normal" }).bg))
    end
  end,
})
vim.api.nvim_create_autocmd("UILeave", {
  group = augroup,
  callback = function()
    io.write("\027]111\027\\")
  end,
})
