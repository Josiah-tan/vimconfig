
if has('nvim')
	lua require("josiah.repl")
	nnoremap <leader>sv <cmd>lua require("repl-nvim.builtin.python").sourceVenv(1)<CR>
	nnoremap <leader>si <cmd>lua require("repl-nvim.builtin.python").sourceInstallModules(1)<CR>

	if g:use_josiah_jupyter
		nnoremap <leader>jq <cmd>lua require("repl-nvim.builtin.python").replInit(4)<cr>
		vnoremap <leader>x <cmd>lua require("repl-nvim.builtin.python").runReplSelection(4)<cr><esc>
		nnoremap <leader>x <cmd>lua require("repl-nvim.builtin.python").runReplBlock(4)<cr>
		nnoremap <leader>xl <cmd>lua require("repl-nvim.builtin.python").runReplLineNoIndent(4)<cr>
	endif
	
	nnoremap <leader>pjq <cmd>lua require("repl-nvim.builtin.cpp").replInit(5)<cr>
	vnoremap <leader>px <cmd>lua require("repl-nvim.builtin.cpp").runReplSelection(5)<cr><esc>
	nnoremap <leader>px <cmd>lua require("repl-nvim.builtin.cpp").runReplBlock(5)<cr>
	nnoremap <leader>pxl <cmd>lua require("repl-nvim.builtin.cpp").runReplLineNoIndent(5)<cr>
endif

" source /home/josiah/Desktop/josiah/plover/benoit-pierre/retro_formatter_with_translations/.tox/dev/bin/activate
