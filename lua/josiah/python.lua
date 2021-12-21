local M = {
	was_init = false,
	previously_indented = false
}

M.sourceVenv = function(term)
	local file = vim.fn.expand("%:t")
	return require("harpoon.term").sendCommand(term, "%s && %s %s && %s\n", "source env/bin/activate", "python3", file, "deactivate")
end

M.sourceInstallModules = function(term)
	local prompt = "enter python module for installation: "
	local response = vim.trim(vim.fn.input({prompt = prompt, cancelreturn = ""}))
	local res
	if string.len(response) ~= 0 then
		res = require("harpoon.term").sendCommand(term, "%s && %s %s && %s\n", "source env/bin/activate", "pip3 install", response, "deactivate")
	end
	return res
end

local lineStartsWithPattern = function(pattern, line, trim_whitespace)
	local pattern_len = string.len(pattern)
	assert(pattern_len >= 1)
	-- removes indentation and other unnecessary whitespace
	if trim_whitespace == nil then
		trim_whitespace = true
	end
	if trim_whitespace then
		line = vim.trim(line)
	end
	-- print(string.sub(line, 1, pattern_len) == pattern)
	return string.len(line) >= pattern_len and string.sub(line, 1, pattern_len) == pattern
end

local lineIsIndented = function (line)
	local char = string.sub(line, 1, 1)
	return char == " " or char == '\t'
end

local sendLine = function (line, term)
	if lineIsIndented(line) then
		M.previously_indented = true
	elseif M.previously_indented then
		require("harpoon.term").sendCommand(term, "\n")
		-- print(line)
		-- print("hello")
		M.previously_indented = false
	end

	if not (lineStartsWithPattern("#", line) or line == "") then
		-- P(line)
		require("harpoon.term").sendCommand(term, line .. "\n")
	end
end

M.PythonInit = function(term)
	require("harpoon.term").sendCommand(term, "source env/bin/activate && python3\n")
	M.was_init = true
end

-- code for having a jupyter like experience
M.runPythonSelection = function(term)
	if M.was_init == false then
		M.PythonInit(term)
	end
	local lower = vim.fn.getpos("v")[2]
	local upper = vim.fn.getpos(".")[2]
	if lower > upper then
		lower, upper = upper, lower
	end
	while lower <= upper do
		sendLine(vim.fn.getline(lower), term)
		lower = lower + 1
	end
	require("harpoon.term").sendCommand(term, "\n")
end

M.runPythonBlock = function(term)
	if M.was_init == false then
		M.PythonInit(term)
	end
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
		else
			sendLine(line, term)
		end
		line_num = line_num + 1;
	end
	require("harpoon.term").sendCommand(term, "\n")
end

return M
