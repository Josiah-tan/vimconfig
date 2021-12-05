if has('nvim')
	" ################################################################ Vim Plugin Settings ################################################################
	"Plugin for neovim with org mode
	" Plug 'nvim-orgmode/orgmode'
	lua require('josiah.org')

	" autocmd FileType org setlocal iskeyword+=:,#,+ |
	" 			\ lua require'completion'.on_attach()
endif
