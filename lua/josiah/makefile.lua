M = {}

require("makefile_nvim").setup()


-- vim.api.nvim_set_keymap("n", "<Leader>mtt", ':lua RELOAD("josiah.makefile").getMakeOptions()<CR>', {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>mf", ':lua RELOAD("makefile_nvim.builtin").makeFile({term = 1})<CR>', {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>mt", ':lua RELOAD("makefile_nvim.builtin").makeFile({term = 1, selection = "test"})<CR>', {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>ma", ':lua RELOAD("makefile_nvim.builtin").makeFile({term = 1, selection = "all"})<CR>', {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>mc", ':lua RELOAD("makefile_nvim.builtin").makeFile({term = 1, selection = "clean"})<CR>', {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>md", ':lua RELOAD("makefile_nvim.builtin").makeFile({term = 1, selection = "docs"})<CR>', {noremap = true, silent = true, expr = false})


return M
