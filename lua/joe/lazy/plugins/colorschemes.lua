local lazy_spec = require("joe.util.colorscheme").lazy_spec

return {
    lazy_spec("catppuccin/nvim"),
    lazy_spec("sainnhe/gruvbox-material", { setup = false }),
    lazy_spec("rebelot/kanagawa.nvim"),
    lazy_spec("EdenEast/nightfox.nvim", { style = "terafox" }),
    lazy_spec("rose-pine/neovim"),
    lazy_spec("sainnhe/sonokai"),
    lazy_spec("folke/tokyonight.nvim")
}