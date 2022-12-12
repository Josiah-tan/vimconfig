if has('nvim')
	lua require('user.treesitter')
	nnoremap <leader>pt :TSPlaygroundToggle<CR>
	" set foldmethod=expr
	" set foldexpr=nvim_treesitter#foldexpr()
	" autocmd BufEnter *.* nnoremap <leader>rac vac
endif
