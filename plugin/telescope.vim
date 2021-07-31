
if has('nvim')
	lua require("josiah")

	" <C-c> exit telescope
	" Using Lua functions

	nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
	nnoremap <leader>lg <cmd>lua require('telescope.builtin').live_grep()<cr>
	"note that <leader>gs collides with git status remap
	nnoremap <leader>sg <cmd>lua require('telescope.builtin').grep_string()<cr>
	nnoremap <leader>ht <cmd>lua require('telescope.builtin').help_tags()<cr>
	nnoremap <leader>gd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
	nnoremap <leader>gr <cmd>lua require('telescope.builtin').lsp_references()<cr>
	nnoremap <leader>gi <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
	nnoremap <leader>gf <cmd>lua require('telescope.builtin').git_files()<cr>

	" Custom

	nnoremap <leader>vr <cmd>lua require('josiah.telescope').search_dotfiles()<cr>
	nnoremap <leader>fb <cmd>lua require('josiah.telescope').buffers()<cr>
	nnoremap <leader>gb <cmd>lua require('josiah.telescope').git_branches()<cr>

endif
