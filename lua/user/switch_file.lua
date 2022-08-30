
M = {}

-- defined in switch_file.lua
local switchIncludeSource = function(filename)
	if vim.fn.substitute(filename, "^src/", "include/", "") == filename then
		filename = vim.fn.substitute(filename, "^include/", "src/", "")
	else
		filename = vim.fn.substitute(filename, "^src/", "include/", "")
	end
	return filename
end

-- P(switchIncludeSource("include/hello"))
-- P(switchIncludeSource("src/hello"))
-- P(switchIncludeSource("hello"))
-- P(switchIncludeSource("hello/src/"))
-- P(switchIncludeSource("hello/src/hello"))

M.fileSwitch = function(pattern)
	local filename = vim.fn.expand("%:r")
	local extension = vim.fn.expand("%:e")
	local current_index = nil
	for index, value in ipairs(pattern) do
		if value:match("(.*)"..extension.."$") then
			current_index = index
		end
	end
	if current_index == nil then
		print("Invalid file extension: "..extension.." not in "..vim.inspect(pattern))
		return
	elseif current_index == #pattern then
		current_index = 1
	else
		current_index = current_index + 1
	end
	local new_file = filename.."."..pattern[current_index]:match("[.](.*)$")
	new_file = switchIncludeSource(new_file)
	vim.cmd(":e "..new_file)
	print(":e ".. new_file)
end

vim.keymap.set("n", "<leader>scw", function() require("user.switch_file").fileSwitch({'*.h', '*.c'}) end)
vim.keymap.set("n", "<leader>spw", function() require("user.switch_file").fileSwitch({'*.h', '*.cpp'}) end)
return M

