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
	lua require("josiah.completion")
	lua require("josiah.lsp")

	" let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

	" lua require("josiah.lsp").setupPyright()
	lua require("josiah.lsp").setupPylsp()
	lua require("josiah.lsp").setupClangd()
	lua require("josiah.lsp").sumnekoLua()
	" lua RELOAD("josiah.lsp").texlab()

	nnoremap <leader>K <cmd>lua vim.lsp.buf.hover()<cr>
	nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<cr>


else
	" ################################################################ Vim Plugin Settings ################################################################

	" for language server (lsp)
	" Plug 'neoclide/coc.nvim', {'branch': 'release'}
	nmap <leader>gd <Plug>(coc-definition)
	nmap <leader>gr <Plug>(coc-references)

endif

