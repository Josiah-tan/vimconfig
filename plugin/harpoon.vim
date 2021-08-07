
if has('nvim')
	" lua package.loaded['josiah.primeagen'] = nil
	lua require('josiah.primeagen')
	" Plugin for neovim terminals
	" Plug 'ThePrimeagen/harpoon'
	"nice little mappings for different terminals using hjkj keys for easy navigation

	" note that RELOAD is for dev purposes (allows a fresh read of the lua
	" file everytime you call the keybinding)
	" nnoremap <leader>rl <cmd>lua RELOAD("josiah.primeagen").makePdf("pdflatex")<cr>

	" n = normal, nore = no recursive, map just a mapping, <leader> is a predefined key, 
	" run latex
	nnoremap <leader>rl <cmd>lua RELOAD("josiah.primeagen").makePdf("pdflatex")<cr>
	nnoremap <leader>th <cmd>lua require("harpoon.term").gotoTerminal(1)<cr>
	nnoremap <leader>tj <cmd>lua require("harpoon.term").gotoTerminal(2)<cr>
	nnoremap <leader>tk <cmd>lua require("harpoon.term").gotoTerminal(3)<cr>
	nnoremap <leader>tl <cmd>lua require("harpoon.term").gotoTerminal(3)<cr>
endif
