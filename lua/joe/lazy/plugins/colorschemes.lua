local lazy_spec = require("joe.util.colorscheme").lazy_spec

return {
  lazy_spec("EdenEast/nightfox.nvim"),
  lazy_spec("Shatur/neovim-ayu", { name = "ayu" }),
  lazy_spec("catppuccin/nvim"),
  lazy_spec("folke/tokyonight.nvim"),
  lazy_spec("rebelot/kanagawa.nvim"),
  lazy_spec("rose-pine/neovim"),
  lazy_spec("sainnhe/everforest", { setup = false }),
  lazy_spec("sainnhe/gruvbox-material", { setup = false }),
  lazy_spec("sainnhe/sonokai", { setup = false }),
  lazy_spec("navarasu/onedark.nvim", { opts = { style = "warmer" } }),
  lazy_spec("scottmckendry/cyberdream.nvim"),
  lazy_spec("vague2k/vague.nvim"),
}
