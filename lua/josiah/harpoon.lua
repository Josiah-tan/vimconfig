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

local lineStartsWithPattern = function(pattern, line)
	local pattern_len = string.len(pattern)
	assert(pattern_len >= 1)
	return string.len(line) >= pattern_len and string.sub(line, 1, pattern_len) == pattern 
end

M.runPythonBlock = function()
	local line_num = vim.fn.getpos(".")[2]
	while line_num > 1 do
		if lineStartsWithPattern("##", vim.fn.getline(line_num)) then
			line_num = line_num + 1
			break
		end
		line_num = line_num - 1
	end
	-- P(line_num)
	-- P(vim.fn.getpos("$")[2])
	while line_num <= vim.fn.getpos("$")[2] do
		local line = vim.fn.getline(line_num)
		if lineStartsWithPattern("##", line) then
			break
		elseif lineStartsWithPattern(" ", line) then
			-- P(line)
			-- P("\n")
			require("harpoon.term").sendCommand(4, line .. "\n\n")
		elseif not (lineStartsWithPattern("#", line) or line == "") then
			-- P(line)
			require("harpoon.term").sendCommand(4, line .. "\n")
		end
		line_num = line_num + 1;
	end
end

return M
