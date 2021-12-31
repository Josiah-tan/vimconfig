
if has('nvim')
	lua require("josiah.python")
	nnoremap <leader>sv <cmd>lua RELOAD("josiah.python").sourceVenv(1)<CR>
	nnoremap <leader>si <cmd>lua RELOAD("josiah.python").sourceInstallModules(1)<CR>

	if g:use_josiah_jupyter
		nnoremap <leader>jq <cmd>lua require("josiah.python").PythonInit(4)<cr>
		vnoremap <leader>x <cmd>lua require("josiah.python").runPythonSelection(4)<cr><esc>
		nnoremap <leader>x <cmd>lua require("josiah.python").runPythonBlock(4)<cr>
		nnoremap <leader>xl <cmd>lua require("josiah.python").runPythonLineNoIndent(4)<cr>
	endif
endif


