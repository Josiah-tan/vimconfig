local M = {}

M.runLatex = function(compiler)
	vim.fn.execute(":w")
	local file_name = vim.fn.expand("%:r")
	compile_string = string.format("%s %s", compiler, file_name)
	combile_bib_string = string.format("bibtex %s", file_name)
	require("harpoon.term").sendCommand(1, "%s && %s && %s && %s && make\n", compile_string, combile_bib_string, compile_string, compile_string)
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
	require("harpoon.term").sendCommand(4, "\n")
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
		elseif not (lineStartsWithPattern("#", line) or line == "") then
			-- P(line)
			require("harpoon.term").sendCommand(4, line .. "\n")
		end
		line_num = line_num + 1;
	end
	require("harpoon.term").sendCommand(4, "\n")
end

return M
