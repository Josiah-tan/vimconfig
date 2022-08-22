M = {}

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
	print(":e ".. new_file)
end

-- vim.api.nvim_set_keymap("n", "<Leader>ch", ':lua RELOAD("user.cht_sh").cheatSh()<CR>', {noremap = true, silent = true, expr = false})
-- lua RELOAD("user.cpp").fileSwitch({'*.h', '*.c'})
vim.api.nvim_set_keymap("n", "<leader>scw", ":lua RELOAD('user.switch_file').fileSwitch({'*.h', '*.c'})<CR>", {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<leader>spw", ":lua RELOAD('user.switch_file').fileSwitch({'*.h', '*.cpp'})<CR>", {noremap = true, silent = true, expr = false})
-- vim.api.nvim_set_keymap("n", "<leader>sw", ":lua RELOAD('user.cpp').fileSwitch({'*.h', '*.lua'})<CR>", {noremap = true, silent = true, expr = false})

return M
