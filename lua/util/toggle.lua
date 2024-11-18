-- Inspired by https://github.com/folke/snacks.nvim

local M = {}

local toggle = {}

function toggle:new(name, opts)
	local tbl = {
		name = name,
	}
	tbl = vim.tbl_deep_extend("force", opts, tbl)
	tbl.states = opts.states or { true, false }
	return setmetatable(tbl, { __index = self, __call = self.toggle })
end

function toggle:toggle()
	local cur_state = self.get()
	local i = vim.fn.index(self.states, cur_state) + 1 -- returns 0-based index
	if i == 0 then
		-- if current state not in list of states, assume current state is first
		i = 1
	else
	end
	local new_state = self.states[(i % #self.states) + 1]
	self.set(new_state)

	local msg
	if new_state == true then
		msg = "Enabled " .. self.name
	elseif new_state == false then
		msg = "Disabled " .. self.name
	else
		msg = self.name .. " set to '" .. tostring(new_state) .. "'"
	end
	if self.buffer_local then
		msg = msg .. " " .. "for current buffer"
	end
	vim.notify(msg, vim.log.levels.INFO, { title = self.name })
end

function toggle:map(keys)
	local desc = "Toggle " .. self.name
	if self.buffer_local then
		desc = desc .. " " .. "in Current Buffer"
	end
	vim.keymap.set("n", keys, function()
		self()
	end, { desc = desc })
end

function M.vim_opt(opt, opts)
	opts = opts or {}
	local name
	if opts.name then
		name = opts.name
	else
		name = opt:sub(1, 1):upper() .. opt:sub(2)
	end
	return toggle:new(name, {
		buffer_local = opts.buffer_local,

		get = function()
			if opts.buffer_local then
				return vim.opt_local[opt]:get()
			end
			return vim.opt[opt]:get()
		end,
		set = function(state)
			if opts.buffer_local then
				vim.opt_local[opt] = state
				return
			end
			vim.opt[opt] = state
		end,
	})
end

function M.vim_var(v, opts)
	opts = opts or {}
	local name
	if opts.name then
		name = opts.name
	else
		name = v:sub(1, 1):upper() .. v:sub(2)
	end
	return toggle:new(name, {
		buffer_local = opts.buffer_local,

		get = function()
			if opts.buffer_local then
				return vim.b[v]
			end
			return vim.g[v]
		end,
		set = function(state)
			if opts.buffer_local then
				vim.b[v] = state
				return
			end
			vim.g[v] = state
		end,
	})
end

function M.diagnostics()
	return toggle:new("Diagnostics", {
		get = function()
			return vim.diagnostic.is_enabled()
		end,
		set = function(state)
			vim.diagnostic.enable(state)
		end,
	})
end

function M.inlay_hints(opts)
	opts = opts or {}
	return toggle:new("Inlay Hints", {
		buffer_local = opts.buffer_local,

		get = function()
			if opts.buffer_local then
				return vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
			end
			return vim.lsp.inlay_hint.is_enabled()
		end,
		set = function(state)
			if opts.buffer_local then
				vim.lsp.inlay_hint.enable(state, { bufnr = 0 })
				return
			end
			vim.lsp.inlay_hint.enable(state)
		end,
	})
end

return { toggle = M }
