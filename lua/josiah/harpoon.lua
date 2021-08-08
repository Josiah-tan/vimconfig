local M = {}

M.runLatex = function(compiler)
	local file_name = vim.fn.expand("%:p")
	require("harpoon.term").sendCommand(1, string.format("%s %s\n", compiler, file_name))
end

M.runPythonSelection = function()
	local lower = vim.fn.getpos("v")[2]
	local upper = vim.fn.getpos(".")[2]
	if lower > upper then
		lower, upper = upper, lower 
	end

	while lower <= upper do
		require("harpoon.term").sendCommand(4, vim.fn.getline(lower) .. "\n")
		lower = lower + 1
	end
end

M.runPythonBlock = function()
	local line_num = vim.fn.getpos(".")[2]
	P(line_num)
end

return M
