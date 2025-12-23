---@class Cheaty.Window
---@field config? Cheaty.Config
local M = {}

M.win_id = nil ---@type integer
M.buf_id = nil ---@type integer

function M.create_window()
	if not M.config then
		return
	end

	M.buf_id = vim.api.nvim_create_buf(false, true)

	vim.api.nvim_buf_set_lines(M.buf_id, 0, -1, false, M.config.cheatsheet)

	-- Buffer options
	local buffer = vim.bo[M.buf_id]

	buffer.buftype = "nofile"
	buffer.bufhidden = "wipe"
	buffer.modifiable = false
	buffer.swapfile = false
	buffer.filetype = "markdown"

	vim.api.nvim_buf_call(M.buf_id, function()
		-- vim.cmd("doautocmd FileType markdown")
		vim.api.nvim_exec_autocmds("FileType", { pattern = "markdown" })
	end)

	local width = math.floor(vim.o.columns * M.config.width)
	local height = math.floor(vim.o.lines * M.config.height)

	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)
	M.win_id = vim.api.nvim_open_win(M.buf_id, true, {
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = height,
		style = "minimal",
		border = "rounded",
	})

	vim.keymap.set("n", "q", M.close, { buffer = M.buf_id, noremap = true, silent = true })
end

function M.close()
	if M.win_id and vim.api.nvim_win_is_valid(M.win_id) then
		vim.api.nvim_win_close(M.win_id, true)
	end

	M.win_id = nil
	M.buf_id = nil
end

function M.toggle()
	if M.win_id and vim.api.nvim_win_is_valid(M.win_id) then
		M.close()
		return
	end

	M.create_window()
end

return M
-- vim: set ts=4 sts=4 sw=0 noet ai si sta:
