local Job = require"plenary.job"
local M = {
}

M.getSource = function()
	-- if vim.fn.getcwd() == "/home/user/Desktop/user/neovim/plover/plover_clippy_2" then
	if string.match(vim.fn.system("whoami"), "user") then
		return "/home/user/Desktop/user/plover/benoit-pierre/retro_formatter_with_translations/.tox/dev/bin/"
	elseif string.match(vim.fn.system("whoami"), "chicken") then
		-- return "/home/chicken/Desktop/user/plover/benoit-pierre/retro_formatter_with_translations/.tox/dev/bin/"
		local tox_directory = vim.fn.getcwd().."/.tox"
		if string.match(vim.fn.getcwd(), vim.fn.expand("~/.dotfiles/plover/.config/plover/vim")) then
			return vim.fn.expand("~/plover/.tox/dev/bin/")
		elseif (vim.fn.isdirectory(tox_directory) == 1) then
			local available_environments
			Job:new({
				command = "ls",
				args = {'--hide', 'log'},
				cwd = tox_directory,
				env ={['a'] = 'b'},
				on_exit = function(j, return_value)
					available_environments = j:result()
				end,
			}):sync()
			local binary
			if #available_environments > 0 then
				P("#available_environments: ", #available_environments)
				P("available_environments: ", available_environments)
				local available_environment = available_environments[1]
				P("available_environment : ", available_environment )
				binary = tox_directory.."/"..available_environment.."/bin/"
				P("binary : ", binary )
			end
			return binary
		else
			return ""
		end
		-- if vim.fn.getcwd() == "/home/chicken/work/Robotic-waste-sorting-project/CoppeliaSim-Kuka-Arm-Simulation/CoppeliaSim-Python-Client" or vim.fn.getcwd() == "/home/chicken/work/Robotic-waste-sorting-project/main/CoppeliaSim-Kuka-Arm-Simulation/CoppeliaSim-Python-Client" or vim.fn.getcwd() == "/home/chicken/work/Fork-Robotic-waste-sorting-project/main/CoppeliaSim-Kuka-Arm-Simulation/CoppeliaSim-Python-Client" then
		-- 	return vim.fn.getcwd() .. "/.tox/test_service/bin/"
		-- else
		-- 	return "/home/chicken/plover/.tox/dev/bin/"
		-- end
	else
		return ""
	end
end
-- -- P(M.getSource())
-- P(vim.fn.getcwd().."/.tox")
-- local tox_directory = vim.fn.getcwd().."/.tox"
-- -- local tox_binary_directory = tox_directory..
-- 	-- ls .tox/ --hide "log"
--
-- local available_environments
-- Job:new({
-- 	command = "ls",
-- 	args = {'--hide', 'log'},
-- 	cwd = tox_directory,
-- 	env ={['a'] = 'b'},
-- 	on_exit = function(j, return_value)
-- 		available_environments = j:result()
-- 	end,
-- }):sync()
-- P("available_environments: ", available_environments)
-- P(available_environments)
-- P(vim.fn.isdirectory(vim.fn.getcwd().."/.tox") == 1)
M.getSourceAppend = function(str)
	local source = M.getSource()
	if source ~= "" then
		return source .. str
	else
		return ""
	end
end
-- print(M.getSourceAppend("activate"))
M.setup = function()
	-- P(M.getSourceAppend("activate"))
	require("repl-nvim").setup({
		python = {
			source = M.getSourceAppend("activate")
		}
	})
end

M.setup()
return M
-- local M = {
-- 	was_init = false,
-- 	previously_indented = false
-- }
--
-- local function venvExists()
-- 	return vim.fn.isdirectory(vim.fn.getcwd() .. "/env") == 1 -- the == 1 here is important for lua
-- end
--
-- local function anacondaVenvExists()
-- 	return vim.fn.filereadable(vim.fn.getcwd() .. "/environment.yaml") == 1 -- the == 1 here is important for lua
-- end
--
-- local function getAnacondaVenv()
-- 	local grep = "grep 'name:' environment.yaml"
-- 	local phony_removal = "sed 's/name:[ ]*//'"
-- 	local commands = vim.trim(vim.fn.system(string.format("%s | %s", grep, phony_removal)))
-- 	return commands
-- end
--
--
-- local function wrapVenvOutput(term, output)
-- 	if venvExists() then
-- 		return require("harpoon.term").sendCommand(term, "%s && %s && %s\n", "source env/bin/activate", output, "deactivate")
-- 	-- else
-- 		-- return require("harpoon.term").sendCommand(term, output .. "\n")
--
-- 	-- source /root/anaconda3/bin/activate wmanalysis && conda activate wmanalysis && python3 -m automation_scripts.update_all.py && conda deactivate
-- 	elseif anacondaVenvExists() then
-- 		local name = getAnacondaVenv()
-- 		return require("harpoon.term").sendCommand(term, "source /root/anaconda3/bin/activate "..name.." && conda activate "..name.." && " .. output .." && conda deactivate \n")
-- 	else
-- 		return require("harpoon.term").sendCommand(term, output .. "\n")
-- 	end
-- end
--
-- M.sourceVenv = function(term)
-- 	local file = vim.fn.expand("%")
-- 	wrapVenvOutput(term, string.format("python3 %s", file))
-- 	require("harpoon.term").gotoTerminal(term)
-- end
--
-- M.sourceInstallModules = function(term)
-- 	local prompt = "enter python module for installation: "
-- 	local response = vim.trim(vim.fn.input({prompt = prompt, cancelreturn = ""}))
-- 	local res
-- 	if string.len(response) ~= 0 then
-- 		res = wrapVenvOutput(term, string.format("pip3 install %s", response))
-- 	end
-- 	return res
-- end
--
-- local lineStartsWithPattern = function(pattern, line, trim_whitespace)
-- 	local pattern_len = string.len(pattern)
-- 	assert(pattern_len >= 1)
-- 	-- removes indentation and other unnecessary whitespace
-- 	if trim_whitespace == nil then
-- 		trim_whitespace = true
-- 	end
-- 	if trim_whitespace then
-- 		line = vim.trim(line)
-- 	end
-- 	-- print(string.sub(line, 1, pattern_len) == pattern)
-- 	return string.len(line) >= pattern_len and string.sub(line, 1, pattern_len) == pattern
-- end
--
-- local lineIsIndented = function (line)
-- 	local char = string.sub(line, 1, 1)
-- 	return char == " " or char == '\t'
-- end
--
-- local sendLine = function (line, term)
-- 	if line == "" then
-- 		return
-- 	end
--
-- 	if lineIsIndented(line) then
-- 		M.previously_indented = true
-- 	elseif M.previously_indented then
-- 		require("harpoon.term").sendCommand(term, "\n")
-- 		M.previously_indented = false
-- 	end
--
-- 	if not lineStartsWithPattern("#", line) then
-- 		require("harpoon.term").sendCommand(term, (vim.fn.substitute(line, "%", "%%", "g")) .. "\n") -- escaping strings cause % causes problems with harpoon
-- 	end
-- end
--
-- M.PythonInit = function(term)
-- 	wrapVenvOutput(term, "python3")
-- 	M.was_init = true
-- end
--
-- -- code for having a jupyter like experience
-- M.runPythonSelection = function(term)
-- 	local lower = vim.fn.getpos("v")[2]
-- 	local upper = vim.fn.getpos(".")[2]
-- 	if M.was_init == false then
-- 		M.PythonInit(term)
-- 	end
-- 	if lower > upper then
-- 		lower, upper = upper, lower
-- 	end
-- 	while lower <= upper do
-- 		sendLine(vim.fn.getline(lower), term)
-- 		lower = lower + 1
-- 	end
-- 	require("harpoon.term").sendCommand(term, "\n")
-- end
--
-- M.runPythonBlock = function(term)
-- 	if M.was_init == false then
-- 		M.PythonInit(term)
-- 	end
-- 	local line_num = vim.fn.getpos(".")[2]
-- 	while line_num > 1 do
-- 		if lineStartsWithPattern("##", vim.fn.getline(line_num)) then
-- 			line_num = line_num + 1
-- 			break
-- 		end
-- 		line_num = line_num - 1
-- 	end
-- 	-- P(line_num)
-- 	-- P(vim.fn.getpos("$")[2])
-- 	while line_num <= vim.fn.getpos("$")[2] do
-- 		local line = vim.fn.getline(line_num)
-- 		if lineStartsWithPattern("##", line) then
-- 			break
-- 		else
-- 			sendLine(line, term)
-- 		end
-- 		line_num = line_num + 1;
-- 	end
-- 	require("harpoon.term").sendCommand(term, "\n")
-- end
--
-- M.runPythonLineNoIndent = function (term)
-- 	if M.was_init == false then
-- 		M.PythonInit(term)
-- 	end
-- 	local line = vim.fn.getline(".")
-- 	line = vim.trim(line)
-- 	sendLine(line, term)
-- end
--
-- return M
