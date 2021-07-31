
if !has('nvim')
	" ################################################################ Vim Plugin Settings ################################################################
	" vim specific plugins
	" for fuzzy finder etc...
	" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	" Plug 'junegunn/fzf.vim'
	nnoremap <leader>ff :Files<cr>
	nnoremap <leader>gf :GFiles<cr>
	nnoremap <leader>fb :Buffers<cr>
	nnoremap <leader>ht :Helptags<cr>
endif
