
"for undo trees
" Plug 'mbbill/undotree'
if has("persistent_undo")
	" for some strange reason the undo trees for neovim and vim are incompatible
	let target_path = has('nvim') ? expand('~/.config/nvim/undodir'): expand('~/.vim/undodir')
	" let target_path =  expand('~/.vim/undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

	set noswapfile
	set nobackup
    let &undodir=target_path
    set undofile

	nnoremap <leader>ut :UndotreeToggle<CR>
endif
