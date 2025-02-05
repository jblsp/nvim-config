return {
  import = "plugins.colorschemes",
  init = function()
    vim.cmd.colorscheme(vim.g.colorscheme)
  end
}
