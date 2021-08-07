local M = {}

M.runLatex = function(compiler)
	local file_name = vim.fn.expand("%:p")
	require("harpoon.term").sendCommand(1, string.format("%s %s\n", compiler, file_name))
end

-- print("hello world")
-- print(vim.fn.join(vim.fn.getline("'<",">'")), "\n")
-- local line = debug.getinfo(1).currentline
-- P(line)

M.runPythonSelection = function()
	P(vim.fn.getline(3))
	P(vim.fn.getpos("v")) 
	P(vim.fn.getpos("."))
	-- local cur_line = vim.api.nvim_exec(
	-- [[
	-- 	echo getline(1)
	-- ]],
	-- true)
	-- print(cur_line)

	-- local cur_line = vim.api.nvim_exec(
	-- [[
	-- 	let [line_start, column_start] = getpos("'<")[1:2]
	-- 	let [line_end, column_end] = getpos("'>")[1:2]
	-- 	let lines = getline(line_start, line_end)
	-- 	if len(lines) == 0
	-- 		echo ''
	-- 	endif
	-- 	let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
	-- 	let lines[0] = lines[0][column_start - 1:]
	-- 	echo join(lines, "\n")
	-- ]],
	-- true)
	-- print(cur_line)

	-- local cur_line = vim.api.nvim_exec(
	-- [[
	-- echo [getpos(".")[1], getpos("v")[1]]
	-- ]],
	-- true)

	-- local result = vim.api.nvim_exec(
	-- [[
	-- echo join(getline("'<","'>"), "\n")
	-- ]],
	-- true)
	-- print(result) -- 'hello world'


	-- require("harpoon.term").sendCommand(4, result .. "\n")
end

M.runPythonBlock = function()
	local cur_line = vim.api.nvim_exec(
	[[
	echo getpos(".")[1]
	]],
	true)
	-- echo line('$')
	print(cur_line) -- 'hello world'
end

return M
