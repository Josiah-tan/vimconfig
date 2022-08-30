M = {}

require("makefile_nvim").setup()


vim.api.nvim_set_keymap("n", "<Leader>mf", ':lua require("makefile_nvim.make").run({term = 1})<CR>', {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>mt", ':lua require("makefile_nvim.make").run({term = 1, selection = "test"})<CR>', {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>ma", ':lua require("makefile_nvim.make").run({term = 1, selection = "all"})<CR>', {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>mc", ':lua require("makefile_nvim.make").run({term = 1, selection = "clean"})<CR>', {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>md", ':lua require("makefile_nvim.make").run({term = 1, selection = "docs"})<CR>', {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>ms", ':lua require("makefile_nvim.make").run({term = 1, selection = "stress"})<CR>', {noremap = true, silent = true, expr = false})


vim.api.nvim_set_keymap("n", "<Leader>txf", ':lua require("makefile_nvim.tox").run({term = 1})<CR>', {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>txt", ':lua require("makefile_nvim.tox").run({term = 1, selection = "test"})<CR>', {noremap = true, silent = true, expr = false})

-- defined in makefile.lua
local CMakeFile = function(opts)
	vim.cmd[[:wa]]
	build_directory = vim.fn.getcwd().."/build"
	if vim.fn.isdirectory(build_directory) then
		require("harpoon.term").sendCommand(opts.term, "cd "..build_directory.."\n")
		require("harpoon.term").sendCommand(opts.term, "cmake ..\n")
		require("harpoon.term").sendCommand(opts.term, "cmake  --build .\n")
	end
	require("harpoon.term").gotoTerminal(opts.term)
end

vim.keymap.set("n", "<leader>cmf", function () CMakeFile({term = 1}) end)
-- vim.keymap.set("n", "<leader>cmf", function () require("harpoon.term").sendCommand(1, [[cd]]) end))
-- vim.api.
return M
