---Non-legacy validation spec (>=v0.11)
---@class ValidateSpec
---@field [1] any
---@field [2] vim.validate.Validator
---@field [3]? boolean
---@field [4]? string

---@class cheaty.Util
local M = {}

---Dynamic `vim.validate()` wrapper. Covers both legacy and newer implementations
---@param T table<string, vim.validate.Spec|ValidateSpec>
function M.validate(T)
	local max = vim.fn.has("nvim-0.11") == 1 and 3 or 4
	for name, spec in pairs(T) do
		while #spec > max do
			table.remove(spec, #spec)
		end
		T[name] = spec
	end

	if vim.fn.has("nvim-0.11") == 1 then
		for name, spec in pairs(T) do
			table.insert(spec, 1, name)
			vim.validate(unpack(spec))
		end
		return
	end

	vim.validate(T)
end

return M
