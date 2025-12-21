local M = {}

local defaults = {
	keymap     = "<leader>cs",
	width      = 0.6,
	height     = 0.6,
	cheatsheet = { "This is a placeholder cheatsheet!", "Add your own in the config!" }
}

M.config = {}

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", defaults, opts or {})

	vim.keymap.set('n', M.config.keymap, function()
		require("cheaty.window").toggle(M.config)
	end, { desc = "Toggle cheaty.nvim cheatsheet" })
end

return M
