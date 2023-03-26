
if has('nvim')
	lua require("user.repl")
	nnoremap <leader>sv <cmd>lua require("repl-nvim.builtin.python").sourceVenv(1)<CR>
	nnoremap <leader>si <cmd>lua require("repl-nvim.builtin.python").sourceInstallModules(1)<CR>

	if g:use_user_jupyter
		nnoremap <leader>jq <cmd>lua require("repl-nvim.builtin.python").replInit(4)<cr>
		vnoremap <leader>x <cmd>lua require("repl-nvim.builtin.python").runReplSelection(4)<cr><esc>
		nnoremap <leader>x <cmd>lua require("repl-nvim.builtin.python").runReplBlock(4)<cr>
		nnoremap <leader>xl <cmd>lua require("repl-nvim.builtin.python").runReplLineNoIndent(4)<cr>
	endif
	
	nnoremap <leader>pjq <cmd>lua require("repl-nvim.builtin.cpp").replInit(5)<cr>
	vnoremap <leader>px <cmd>lua require("repl-nvim.builtin.cpp").runReplSelection(5)<cr><esc>
	nnoremap <leader>px <cmd>lua require("repl-nvim.builtin.cpp").runReplBlock(5)<cr>
	nnoremap <leader>pxl <cmd>lua require("repl-nvim.builtin.cpp").runReplLineNoIndent(5)<cr>
	
	nnoremap <leader>msv <cmd>lua require("repl-nvim.builtin.matlab").sourceVenv(1)<CR>
	nnoremap <leader>mjq <cmd>lua require("repl-nvim.builtin.matlab").replInit(5)<cr>
	vnoremap <leader>mx <cmd>lua require("repl-nvim.builtin.matlab").runReplSelection(5)<cr><esc>
	nnoremap <leader>mx <cmd>lua require("repl-nvim.builtin.matlab").runReplBlock(5)<cr>
	nnoremap <leader>mxl <cmd>lua require("repl-nvim.builtin.matlab").runReplLineNoIndent(5)<cr>
endif

" source /home/user/Desktop/user/plover/benoit-pierre/retro_formatter_with_translations/.tox/dev/bin/activate
