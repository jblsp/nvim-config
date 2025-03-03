local autocmd = util.autocmd

local augroup = util.autocmd.group("correct-terminal-colors")

autocmd.create({ "UIEnter", "ColorScheme" }, {
  -- see: https://www.reddit.com/r/neovim/comments/1ehidxy/you_can_remove_padding_around_neovim_instance/"
  desc = "Corrects terminal background color according to colorscheme",
  group = augroup,
  callback = function()
    if vim.api.nvim_get_hl(0, { name = "Normal" }).bg then
      io.write(string.format("\027]11;#%06x\027\\", vim.api.nvim_get_hl(0, { name = "Normal" }).bg))
    end
  end,
})
autocmd.create("UILeave", {
  group = augroup,
  callback = function()
    io.write("\027]111\027\\")
  end,
})
