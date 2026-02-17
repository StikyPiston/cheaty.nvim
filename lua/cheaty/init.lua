---@class Cheaty.Config
---@field keymap? string
---@field width? number
---@field height? number
---@field cheatsheet? string[]
local defaults = {
	width      = 0.6,
	height     = 0.6,
	cheatsheet = { "# This is a sample cheatsheet!", "Tailor it to your liking in the config!" }
}

---@class Cheaty
local M = {}

M.config = {} ---@type Cheaty.Config

---@param opts? Cheaty.Config
function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", defaults, opts or {})

	vim.api.nvim_create_user_command(
		'Cheaty',
		function() require("cheaty.window").toggle(M.config) end,
		{ desc = "Open Cheatsheet" }
	)
end

return M
-- vim: set ts=4 sts=4 sw=0 noet ai si sta:
