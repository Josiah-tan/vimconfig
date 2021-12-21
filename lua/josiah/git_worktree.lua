require("git-worktree").setup({
})

require("telescope").load_extension("git_worktree")

vim.api.nvim_set_keymap("n", "<Leader>wg", [[<Esc><Cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>wc", [[<Esc><Cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>]], {noremap = true, silent = true, expr = false})

