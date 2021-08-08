local M = {}

M.runLatex = function(compiler)
	local file_name = vim.fn.expand("%:p")
	require("harpoon.term").sendCommand(1, string.format("%s %s\n", compiler, file_name))
end

M.runPythonSelection = function()
	local line_num = vim.fn.getpos("v")[2]
	local line_num_2 = vim.fn.getpos(".")[2]
	local lower = math.min(line_num, line_num_2)
	local upper = math.max(line_num, line_num_2)
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
