local M = {}

local win_id = nil
local buf_id = nil

local function create_window(cfg)
	buf_id = vim.api.nvim_create_buf(false, true)

	vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, cfg.cheatsheet)

	-- Buffer options
	local buffer = vim.bo[buf_id]

	buffer.buftype    = "nofile"
	buffer.bufhidden  = "wipe"
	buffer.modifiable = false
	buffer.swapfile   = false
	buffer.filetype   = "markdown"

	local width = math.floor(vim.o.columns * cfg.width)
	local height = math.floor(vim.o.lines * cfg.height)

	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.lines - width) / 2)

	win_id = vim.api.nvim_open_win(buf_id, true, {
		relative = "editor",
		row      = row,
		col      = col,
		width    = width,
		height   = height,
		style    = "minimal",
		border   = "rounded"
	})
end

function M.close()
	if win_id and vim.api.nvim_win_is_valid(win_id) then
		vim.api.nvim_win_close(win_id, true)
	end

	win_id = nil
	buf_id = nil
end

function M.toggle(cfg)
	if win_id and vim.api.nvim_win_is_valid(win_id) then
		M.close()
	else
		create_window(cfg)
	end
end

return M
