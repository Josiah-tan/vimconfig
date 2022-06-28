"kite settings (for some reason kite is so dodgy that it doesn't even use vim-plug
" disabling kite
let g:kite_supported_languages = []

if has('nvim')
	" ################################################################ Neovim Plugin Settings ################################################################
	" neovim specific plugins
	
	" plugin for lsp configurations
	" https://microsoft.github.io/language-server-protocol/implementors/servers/
	" Plug 'neovim/nvim-lspconfig'
	" pyright

	" for autocompletion
	" Plug 'nvim-lua/completion-nvim'
	" lua require("josiah.completion").setup()
	lua require("josiah.lsp")

	" let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

	" lua require("josiah.lsp").setupPyright()
	lua require("josiah.lsp").setupPylsp()
	lua require("josiah.lsp").setupClangd()
	lua require("josiah.lsp").sumnekoLua()
	lua require("josiah.lsp").setupArduino()
	" lua RELOAD("josiah.lsp").texlab()

	nnoremap <leader>K <cmd>lua vim.lsp.buf.hover()<cr>
	nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<cr>
	nnoremap <leader>dn <cmd>lua vim.diagnostic.goto_next()<cr> 
	nnoremap <leader>dp <cmd>lua vim.diagnostic.goto_prev()<cr> 

	augroup COMPLETION  
		" the reason why this was included is because for some reason the
		" completion doesn't work when I call it normally?
		autocmd!
		autocmd BufEnter * ++once :lua require("josiah.completion").setup()
		" autocmd BufEnter * ++once :lua print("hello world")
	augroup END

else
	" ################################################################ Vim Plugin Settings ################################################################

	" for language server (lsp)
	" Plug 'neoclide/coc.nvim', {'branch': 'release'}
	nmap <leader>gd <Plug>(coc-definition)
	nmap <leader>gr <Plug>(coc-references)

endif

