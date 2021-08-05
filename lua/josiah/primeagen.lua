local M = {}

M.makePdf = function(compiler)
	local file_name = vim.fn.expand("%:p")
	require("harpoon.term").sendCommand(1, string.format("%s %s", compiler, file_name))
end

return M
