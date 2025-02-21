local autocmd = vim.api.nvim_create_autocmd

local function augroup(name, opts)
  opts = opts or { clear = true }
  return vim.api.nvim_create_augroup(name, opts)
end

autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = augroup("highlight-yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local cmdlinenrs_group = augroup("cmdlinenrs")
local cmdline_debounce_timer
autocmd("CmdlineEnter", {
  desc = "Disable relative line numbers in command mode",
  group = cmdlinenrs_group,
  callback = function()
    cmdline_debounce_timer = vim.uv.new_timer()
    cmdline_debounce_timer:start(
      5,
      0,
      vim.schedule_wrap(function()
        if vim.o.number then
          vim.o.relativenumber = false
          vim.api.nvim__redraw({ statuscolumn = true })
        end
      end)
    )
  end,
})
autocmd("CmdlineLeave", {
  desc = "Enable relative line numbers (if enabled)",
  group = cmdlinenrs_group,
  callback = function()
    if cmdline_debounce_timer then
      cmdline_debounce_timer:stop()
      cmdline_debounce_timer = nil
    end
    if vim.o.number then
      vim.o.relativenumber = true
    end
  end,
})

autocmd("BufWritePre", {
  desc = "Auto create directory when saving a file",
  group = augroup("auto-create-dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then -- ignore remote files
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    local parent = vim.fn.fnamemodify(file, ":p:h")
    if vim.fn.isdirectory(parent) == 0 then
      if
        vim.fn.confirm("Directory " .. parent .. " does not exist. Would you like to create it?", "&Yes\n&No") == 1
      then
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
      end
    end
  end,
})

autocmd({ "UIEnter", "ColorScheme" }, {
  desc = "Corrects terminal background color according to colorscheme, see: https://www.reddit.com/r/neovim/comments/1ehidxy/you_can_remove_padding_around_neovim_instance/",
  group = augroup("correct-termianl-color"),
  callback = function()
    if vim.api.nvim_get_hl(0, { name = "Normal" }).bg then
      io.write(string.format("\027]11;#%06x\027\\", vim.api.nvim_get_hl(0, { name = "Normal" }).bg))
    end
    autocmd("UILeave", {
      callback = function()
        io.write("\027]111\027\\")
      end,
    })
  end,
})

autocmd("TermOpen", {
  desc = "Set terminal local opts",
  group = augroup("set-term-mode-opts"),
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

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Restore cursor to position from last edit",
  group = augroup("cursor-restore"),
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.cmd('normal! g`"zz')
    end
  end,
})

autocmd({ "CursorMoved", "CursorMovedI", "WinScrolled" }, {
  desc = "Fix scrolloff when you are at the EOF",
  group = augroup("scroll-eof"),
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
