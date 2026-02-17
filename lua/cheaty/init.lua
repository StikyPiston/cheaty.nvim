local M = {}

local defaults = {
	width      = 0.6,
	height     = 0.6,
	cheatsheet = { "# This is a sample cheatsheet!", "Tailor it to your liking in the config!" }
}

M.config = {}

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", defaults, opts or {})

	vim.api.nvim_create_user_command(
		'Cheaty',
		function() require("cheaty.window").toggle(M.config) end,
		{ desc = "Open Cheatsheet" }
	)
end

return M
