---@class Cheaty.Config
---@field keymap? string
---@field width? number
---@field height? number
---@field cheatsheet? string[]
local defaults = {
	keymap = "<leader>cs",
	width = 0.6,
	height = 0.6,
	cheatsheet = { "# This is a sample cheatsheet!", "Tailor it to your liking in the config!" },
}

---@class Cheaty
local M = {}

M.config = {} ---@type Cheaty.Config

---@param opts? Cheaty.Config
function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", defaults, opts or {})

	local cheaty_win = require("cheaty.window")
	cheaty_win.config = vim.deepcopy(M.config)

	if M.config.keymap and M.config.keymap ~= "" then
		vim.keymap.set(
			"n",
			M.config.keymap,
			cheaty_win.toggle,
			{ desc = "Toggle cheaty.nvim cheatsheet" }
		)
	end

	vim.api.nvim_create_user_command("Cheaty", function()
		cheaty_win.toggle()
	end, { desc = "Toggle the Cheaty Window" })
end

return M
-- vim: set ts=4 sts=4 sw=0 noet ai si sta:
