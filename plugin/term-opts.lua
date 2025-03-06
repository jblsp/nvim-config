local autocmd = util.autocmd

autocmd.create("TermOpen", {
  desc = "Set terminal local opts",
  group = autocmd.group("set-term-mode-opts"),
  callback = function()
    if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "terminal" then
      vim.cmd("startinsert")

      vim.bo.filetype = "terminal"

      local opt = vim.opt_local
      opt.number = false
      opt.relativenumber = false
      opt.signcolumn = "no"
      opt.scrolloff = 0
    end
  end,
})

-- Terminal mode mappings
local function map(lhs, rhs, opts)
  vim.keymap.set("t", lhs, rhs, opts)
end

map("<esc><esc>", "<c-\\><c-n>")
