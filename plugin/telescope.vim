
if has('nvim')
	" This is a requirement, which implements some useful window management
	"   items for neovim
	" Plug 'nvim-lua/popup.nvim'
	" Plug 'nvim-lua/plenary.nvim'

	" fuzzy finder etc...
	" Plug 'nvim-telescope/telescope.nvim'	
	" Plug 'nvim-telescope/telescope-fzy-native.nvim'
	" override the file and generic sorter for telescope

	"user_folder/year_2/uni/amme2500/project1
	"ctrl + t => new terminal window
	"user_folder/work/projects/project2
	"quick projects

	"this is a deprecated version as I have now turned quickProjects into a
	"plugin
	nnoremap <leader>tqp <cmd>lua require('user.telescope').quickProjects()<cr>

	"n = normal mode, nore = not recursive, map = mapping, <leader> = <space>
	nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files({no_ignore=true})<cr>
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
	nnoremap <leader>dd <cmd>lua require('telescope.builtin').diagnostics({bufnr=0})<cr>
	nnoremap <leader>wd <cmd>lua require('telescope.builtin').diagnostics()<cr>
	nnoremap <leader>km <cmd>lua require('telescope.builtin').keymaps()<cr>
	nnoremap <leader>bc <cmd>lua require('telescope.builtin').git_bcommits()<cr>
	nnoremap <leader>gc <cmd>lua require('telescope.builtin').git_commits()<cr>


	" Custom

	nnoremap <leader>fd <cmd>lua RELOAD('user.telescope').findFilesCurrentBufferDir()<cr>
	nnoremap <leader>fp <cmd>lua require('user.telescope').findPlugins()<cr>
	nnoremap <leader>slp <cmd>lua require('user.telescope').stringGrepPlugins()<cr>
	nnoremap <leader>lp <cmd>lua require('user.telescope').grepPlugins()<cr>
	nnoremap <leader>rc <cmd>lua require('user.telescope').searchDotfiles()<cr>
	nnoremap <leader>slc <cmd>lua require('user.telescope').stringGrepDotFiles()<cr>
	nnoremap <leader>lc <cmd>lua require('user.telescope').grepDotFiles()<cr>
	nnoremap <leader>fb <cmd>lua require('user.telescope').buffers()<cr>
	nnoremap <leader>gb <cmd>lua require('user.telescope').gitBranches()<cr>
	
	nnoremap <leader>fs <cmd>lua require('user.telescope').findPloverFiles()<cr>
	nnoremap <leader>sls <cmd>lua require('user.telescope').stringGrepPloverFiles()<cr>
	nnoremap <leader>ls <cmd>lua require('user.telescope').grepPloverFiles()<cr>
	
	nnoremap <leader>fo <cmd>lua require('user.telescope').findOrgFiles()<cr>
	nnoremap <leader>slo <cmd>lua require('user.telescope').stringGrepOrgFiles()<cr>
	nnoremap <leader>lo <cmd>lua require('user.telescope').grepOrgFiles()<cr>
	
	nnoremap <leader>fk <cmd>lua require('user.telescope').findCaptionFiles()<cr>
	nnoremap <leader>slk <cmd>lua require('user.telescope').stringGrepCaptionFiles()<cr>
	nnoremap <leader>lk <cmd>lua require('user.telescope').grepCaptionFiles()<cr>

	nnoremap <leader>fm <cmd>lua require('user.telescope').findStanleyFiles()<cr>
	nnoremap <leader>slm <cmd>lua require('user.telescope').stringGrepStanleyFiles()<cr>
	nnoremap <leader>lm <cmd>lua require('user.telescope').grepStanleyFiles()<cr>
	
	nnoremap <leader>fpc <cmd>lua require('user.telescope').findPloverConfigFiles()<cr>
	nnoremap <leader>slpc <cmd>lua require('user.telescope').stringGrepPloverConfigFiles()<cr>
	nnoremap <leader>lpc <cmd>lua require('user.telescope').grepPloverConfigFiles()<cr>

	nnoremap <leader>ffd <cmd>lua require('user.telescope').findLightFieldFiles()<cr>
	nnoremap <leader>slfd <cmd>lua require('user.telescope').stringGrepLightFieldFiles()<cr>
	nnoremap <leader>lfd <cmd>lua require('user.telescope').grepLightFieldFiles()<cr>
	
	" primeagen
	"  the problem with live_grep is that it is apparently slow in large file
	"  projects, might as well stick with the primagen version where you do a
	"  wordwise grep rather than a characterwise grep which could lead to some
	"  performance issues
	" nnoremap <leader>lg <cmd>lua require('telescope.builtin').live_grep()<cr>
	nnoremap <leader>lg :lua require('user.telescope').liveGrep()<CR>
	" <C-c> exit telescope
	" Using Lua functions
	" require("telescope.previewers").vim_buffer_vimgrep.new
	" previewers.vim_buffer_vimgrep.new

	" autocmd User vim_buffer_vimgrep setlocal wrap

endif
