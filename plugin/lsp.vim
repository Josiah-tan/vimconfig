
if has('nvim')
	" ################################################################ Neovim Plugin Settings ################################################################
	" neovim specific plugins
	
	" plugin for lsp configurations
	" https://microsoft.github.io/language-server-protocol/implementors/servers/
	" Plug 'neovim/nvim-lspconfig'
	" pyright

	" for autocompletion
	" Plug 'nvim-lua/completion-nvim'

	let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
	lua require('lspconfig').pyright.setup{on_attach=require'completion'.on_attach}
	lua require('lspconfig').clangd.setup{on_attach=require'completion'.on_attach}

	nnoremap <leader>K <cmd>lua vim.lsp.buf.hover()<cr>
	nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<cr>


else
	" ################################################################ Vim Plugin Settings ################################################################

	" for language server (lsp)
	" Plug 'neoclide/coc.nvim', {'branch': 'release'}
	nmap <leader>gd <Plug>(coc-definition)
	nmap <leader>gr <Plug>(coc-references)

endif

