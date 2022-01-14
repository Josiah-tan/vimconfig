
if has('nvim')
	" This is a requirement, which implements some useful window management
	"   items for neovim
	" Plug 'nvim-lua/popup.nvim'
	" Plug 'nvim-lua/plenary.nvim'

	" fuzzy finder etc...
	" Plug 'nvim-telescope/telescope.nvim'	
	" Plug 'nvim-telescope/telescope-fzy-native.nvim'
	" override the file and generic sorter for telescope

	"josiah_folder/year_2/uni/amme2500/project1
	"ctrl + t => new terminal window
	"josiah_folder/work/projects/project2
	"quick projects

	"this is a deprecated version as I have now turned quickProjects into a
	"plugin
	nnoremap <leader>tqp <cmd>lua require('josiah.telescope').quickProjects()<cr>

	"n = normal mode, nore = not recursive, map = mapping, <leader> = <space>
	nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
	nnoremap <leader>bf <cmd>lua require('telescope.builtin').file_browser()<cr>
	"note that <leader>gs collides with git status remap
	nnoremap <leader>sg <cmd>lua require('telescope.builtin').grep_string()<cr>
	nnoremap <leader>ht <cmd>lua require('telescope.builtin').help_tags()<cr>
	nnoremap <leader>gd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
	nnoremap <leader>gr <cmd>lua require('telescope.builtin').lsp_references()<cr>
	nnoremap <leader>gi <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
	nnoremap <leader>gf <cmd>lua require('telescope.builtin').git_files()<cr>
	nnoremap <leader>ds <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
	nnoremap <leader>ws <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>
	nnoremap <leader>ca <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
	nnoremap <leader>fz <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>


	" Custom

	nnoremap <leader>fd <cmd>lua RELOAD('josiah.telescope').findFilesCurrentBufferDir()<cr>
	nnoremap <leader>fp <cmd>lua require('josiah.telescope').findPlugins()<cr>
	nnoremap <leader>lp <cmd>lua require('josiah.telescope').grepPlugins()<cr>
	nnoremap <leader>rc <cmd>lua require('josiah.telescope').searchDotfiles()<cr>
	nnoremap <leader>lc <cmd>lua require('josiah.telescope').grepDotFiles()<cr>
	nnoremap <leader>fb <cmd>lua require('josiah.telescope').buffers()<cr>
	nnoremap <leader>gb <cmd>lua require('josiah.telescope').gitBranches()<cr>

	" primeagen
	"  the problem with live_grep is that it is apparently slow in large file
	"  projects, might as well stick with the primagen version where you do a
	"  wordwise grep rather than a characterwise grep which could lead to some
	"  performance issues
	" nnoremap <leader>lg <cmd>lua require('telescope.builtin').live_grep()<cr>
	nnoremap <leader>lg :lua require('josiah.telescope').liveGrep()<CR>
	" <C-c> exit telescope
	" Using Lua functions
	" require("telescope.previewers").vim_buffer_vimgrep.new
	" previewers.vim_buffer_vimgrep.new
	
	" autocmd User vim_buffer_vimgrep setlocal wrap

endif
