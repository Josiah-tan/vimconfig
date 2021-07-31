
if has('nvim')
	" Plugin for neovim terminals
	" Plug 'ThePrimeagen/harpoon'
	"nice little mappings for different terminals using hjkj keys for easy navigation
	nnoremap <leader>th <cmd>lua require("harpoon.term").gotoTerminal(1)<cr>
	nnoremap <leader>tj <cmd>lua require("harpoon.term").gotoTerminal(2)<cr>
	nnoremap <leader>tk <cmd>lua require("harpoon.term").gotoTerminal(3)<cr>
	nnoremap <leader>tl <cmd>lua require("harpoon.term").gotoTerminal(3)<cr>
endif
