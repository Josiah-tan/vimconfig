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

return M
