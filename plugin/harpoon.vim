
if has('nvim')
	lua package.loaded['josiah.harpoon'] = nil
	lua require('josiah.harpoon')
	" Plugin for neovim terminals
	" Plug 'Theharpoon/harpoon'
	"nice little mappings for different terminals using hjkj keys for easy navigation

	" note that RELOAD is for dev purposes (allows a fresh read of the lua
	" file everytime you call the keybinding)
	nnoremap <leader>rl <cmd>lua RELOAD("josiah.harpoon").runLatex("lualatex")<cr>
	" vnoremap <leader>rp <cmd>lua RELOAD("josiah.harpoon").runPythonSelection()<cr>
	" nnoremap <leader>rp <cmd>lua RELOAD("josiah.harpoon").runPythonBlock()<cr>

	" n = normal, nore = no recursive, map just a mapping, <leader> is a predefined key, 
	" run latex
	" nnoremap <leader>rl <cmd>lua require("josiah.harpoon").runLatex("lualatex")<cr>
	vnoremap <leader>rp <cmd>lua require("josiah.harpoon").runPythonSelection()<cr>
	nnoremap <leader>rp <cmd>lua require("josiah.harpoon").runPythonBlock()<cr>

	nnoremap <leader>th <cmd>lua require("harpoon.term").gotoTerminal(1)<cr>
	nnoremap <leader>tj <cmd>lua require("harpoon.term").gotoTerminal(2)<cr>
	nnoremap <leader>tk <cmd>lua require("harpoon.term").gotoTerminal(3)<cr>
	nnoremap <leader>tl <cmd>lua require("harpoon.term").gotoTerminal(4)<cr>

	"i for include?
	nnoremap <leader>hi <cmd>lua require("harpoon.mark").add_file()<cr>
	nnoremap <leader>hq <cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>

	nnoremap <leader>hf <cmd>lua require("harpoon.ui").nav_file(1)<cr>
	nnoremap <leader>hd <cmd>lua require("harpoon.ui").nav_file(2)<cr>
	nnoremap <leader>hs <cmd>lua require("harpoon.ui").nav_file(3)<cr>
	nnoremap <leader>ha <cmd>lua require("harpoon.ui").nav_file(4)<cr>
endif
