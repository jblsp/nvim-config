local M = {}

function M.is_buf_empty(bufnr)
	return vim.api.nvim_buf_get_name(bufnr) == "" and vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)[1] == ""
end

function M.is_buf_active(bufnr, exclude_win)
	exclude_win = exclude_win or {}
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if not vim.list_contains(exclude_win, win) and vim.api.nvim_win_get_buf(win) == bufnr then
			return true
		end
	end
	return false
end

function M.set_cwd(dir)
	vim.fn.chdir(dir)
	vim.notify("cwd set to " .. dir, vim.log.levels.INFO)
end

function M.in_git_project()
	local cmd = "git rev-parse --is-inside-work-tree"
	return vim.fn.system(cmd) == "true\n"
end

return M
