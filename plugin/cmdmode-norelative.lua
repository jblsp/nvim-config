local reset_group = vim.api.nvim_create_augroup("cmdmode-norelative-reset", { clear = true })

vim.api.nvim_create_autocmd("CmdlineEnter", {
  desc = "Disable relative line numbers in command mode",
  group = vim.api.nvim_create_augroup("cmdmode-norelative", { clear = true }),
  callback = function()
    if not vim.tbl_contains({ ":", "/", "?" }, vim.fn.getcmdtype()) then
      return
    end

    local modified_wins = {}
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_get_option_value("relativenumber", { win = win }) == true then
        vim.api.nvim_set_option_value("relativenumber", false, { win = win })
        table.insert(modified_wins, win)
      end
    end
    vim.api.nvim__redraw({ statuscolumn = true })

    vim.api.nvim_create_autocmd("CmdlineLeave", {
      group = reset_group,
      callback = function()
        for _, win in ipairs(modified_wins) do
          vim.api.nvim_set_option_value("relativenumber", true, { win = win })
        end
        vim.api.nvim_clear_autocmds({ group = reset_group })
      end,
    })
  end,
})
