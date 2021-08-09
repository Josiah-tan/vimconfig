local M = {}

M.linkUnderCursor = function()
	local line = vim.fn.getline(".")
	vim.fn.system('xdg-open ' .. line)
end

return M
