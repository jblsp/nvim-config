local ls = require("joe.util.colorscheme").make_lazy_spec

return {
  ls("EdenEast/nightfox.nvim"),
  ls("Shatur/neovim-ayu", { name = "ayu" }),
  ls("catppuccin/nvim"),
  ls("folke/tokyonight.nvim"),
  ls("rebelot/kanagawa.nvim"),
  ls("rose-pine/neovim"),
  ls("sainnhe/everforest", { setup = false }),
  ls("sainnhe/gruvbox-material", { setup = false }),
  ls("sainnhe/sonokai", { setup = false }),
  ls("navarasu/onedark.nvim", { opts = { style = "warmer" } }),
  ls("scottmckendry/cyberdream.nvim"),
  ls("vague2k/vague.nvim"),
}
