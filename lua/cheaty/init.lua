---@class cheaty
local M = {}

-- stylua: ignore start
---@class cheatyOpts
---@field width? number
---@field height? number
---@field save_file? string
---@field cheatsheet? string[]
local defaults = {
	width      = 0.6,
	height     = 0.6,
	save_file  = vim.fs.joinpath(vim.fn.stdpath("data"), "cheaty.md"),
	cheatsheet = { "# This is a sample cheatsheet!", "Tailor it to your liking in the config!" }
}

M.config = {} ---@type cheatyOpts

---@param opts? cheatyOpts
function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", defaults, opts or {})

	vim.api.nvim_create_user_command(
		'Cheaty',
		function() require("cheaty.window").toggle(M.config) end,
		{ desc = "Open Cheatsheet" }
	)
end

return M
