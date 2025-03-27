vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "WinScrolled" }, {
  desc = "Fix scrolloff when you are at the EOF",
  group = vim.api.nvim_create_augroup("scroll-eof", { clear = true }),
  callback = function()
    if vim.api.nvim_win_get_config(0).relative ~= "" then
      return
    end

    local win_height = vim.fn.winheight(0)
    local scrolloff = math.min(vim.opt.scrolloff:get(), math.floor(win_height / 2))
    local visual_distance_to_eof = win_height - vim.fn.winline()

    if visual_distance_to_eof < scrolloff then
      local win_view = vim.fn.winsaveview()
      vim.fn.winrestview({ topline = win_view.topline + scrolloff - visual_distance_to_eof })
    end
  end,
})
