local Util = require("cheaty.util")

---@class cheaty
local M = {}

-- stylua: ignore start
---@class cheatyOpts
---@field width? number
---@field height? number
---@field save_file? string
---@field cheatsheet? string[]|string
local defaults = {
	width      = 0.6,
	height     = 0.6,
	save_file  = vim.fs.joinpath(vim.fn.stdpath("data"), "cheaty.md"),
	cheatsheet = { "# This is a sample cheatsheet!", "Customise it by editing *this buffer* (just press `i`)", "Or in the `cheatsheet` section of the config!" }
}
-- stylua: ignore end

M.config = {} ---@type cheatyOpts

---@param opts? cheatyOpts
function M.setup(opts)
	Util.validate({ opts = { opts, { "table", "nil" }, true } })
	opts = opts or {}

	Util.validate({
		["opts.width"] = { opts.width, { "number", "nil" }, true },
		["opts.height"] = { opts.height, { "number", "nil" }, true },
		["opts.save_file"] = { opts.save_file, { "string", "nil" }, true },
		["opts.cheatsheet"] = { opts.cheatsheet, { "table", "string", "nil" }, true },
	})

	M.config = vim.tbl_deep_extend("force", defaults, opts or {})

	if M.config.cheatsheet and type(M.config.cheatsheet) == "string" then
		M.config.cheatsheet = vim.split(M.config.cheatsheet, "\n", { trimempty = false })
	end

	vim.api.nvim_create_user_command("Cheaty", function(ctx)
		if vim.tbl_isempty(ctx.fargs) then
			require("cheaty.window").toggle(M.config)
		end

		if ctx.fargs[1] == "reset" then
			require("cheaty.window").reset(M.config)
		end
	end, {
		desc = "Open Cheatsheet",
		nargs = "?",
		complete = function(_, line)
			local args = vim.split(line, "%s+", { trimempty = false })
			if args[1]:sub(-1) == "!" then
				return {}
			end

			if #args == 2 then
				return { "reset" }
			end

			return {}
		end,
	})
end

return M
