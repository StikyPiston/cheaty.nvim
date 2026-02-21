local uv = vim.uv or vim.loop

---@class cheaty.Window
local M = {}

local win_id, buf_id = nil, nil ---@type integer|nil, integer|nil
local fd, stat = nil, nil ---@type integer|nil, uv.fs_stat.result|nil

---@param cfg cheatyOpts
---@param flags? uv.fs_open.flags
local function open_file(cfg, flags)
	if not cfg.save_file or cfg.save_file == "" then
		error("No valid path!", vim.log.levels.ERROR)
	end

	if vim.fn.filereadable(cfg.save_file) ~= 1 then
		vim.fn.writefile(cfg.cheatsheet or {}, cfg.save_file)
	end

	stat = uv.fs_stat(cfg.save_file)
	fd = uv.fs_open(cfg.save_file, flags or "r", tonumber("644", 8))
end

---@param cfg cheatyOpts
local function create_window(cfg)
	buf_id = vim.api.nvim_create_buf(false, true)

	open_file(cfg, "r")

	local contents = cfg.cheatsheet
	if fd and stat then
		contents = vim.split(uv.fs_read(fd, stat.size), "\n", { trimempty = false })
		uv.fs_close(fd)
	end

	vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, contents)

	-- Buffer options
	local opts = { buf = buf_id } ---@type vim.api.keyset.option
	vim.api.nvim_set_option_value("buftype", "nofile", opts)
	-- vim.api.nvim_set_option_value("bufhidden", "wipe", opts)
	vim.api.nvim_set_option_value("modified", false, opts)
	vim.api.nvim_set_option_value("modifiable", true, opts)
	vim.api.nvim_set_option_value("swapfile", false, opts)
	vim.api.nvim_set_option_value("filetype", "markdown", opts)

	local width = math.floor(vim.o.columns * cfg.width)
	local height = math.floor(vim.o.lines * cfg.height)

	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	win_id = vim.api.nvim_open_win(buf_id, true, {
		relative = "editor",
		noautocmd = false,
		title = "Cheaty",
		title_pos = "center",
		row = row,
		col = col,
		width = width,
		height = height,
		style = "minimal",
		border = "rounded",
	})

	vim.keymap.set('n', 'q', M.close, { buffer = buf_id })

	local augroup = vim.api.nvim_create_augroup("cheaty", { clear = true })
	vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
	  group = augroup,
	  buffer = buf_id,
	  callback = function()
		  if not (buf_id and vim.api.nvim_buf_is_valid(buf_id)) then
		    return
		  end

      open_file(cfg, "w")
      if not fd then
        return
      end

      local content = vim.api.nvim_buf_get_lines(buf_id, 0, -1, true)
      uv.fs_write(fd, table.concat(content, "\n"))
      uv.fs_close(fd)
	  end,
	})
end

function M.close()
	if not (buf_id or win_id) then
		return
	end

	pcall(vim.api.nvim_buf_delete, buf_id, { force = true })
	pcall(vim.api.nvim_win_close, win_id, true)

  timer = nil
  fd = nil
  stat = nil
	win_id = nil
	buf_id = nil
end

---@param cfg cheatyOpts
function M.toggle(cfg)
	if win_id and buf_id then
		M.close()
		return
	end

	create_window(cfg)
end

return M
