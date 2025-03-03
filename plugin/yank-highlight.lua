local autocmd = util.autocmd

autocmd.create("TextYankPost", {
  desc = "Highlight when yanking text",
  group = autocmd.group("highlight-yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})
