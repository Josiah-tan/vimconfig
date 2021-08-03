if has('nvim')
	lua require('josiah.treesitter')

	set foldmethod=expr
	set foldexpr=nvim_treesitter#foldexpr()
endif
