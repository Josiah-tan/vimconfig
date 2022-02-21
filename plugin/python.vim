
if has('nvim')
	lua require("josiah.python")
	nnoremap <leader>sv <cmd>lua require("python_nvim.builtin").sourceVenv(1)<CR>
	nnoremap <leader>si <cmd>lua require("python_nvim.builtin").sourceInstallModules(1)<CR>

	if g:use_josiah_jupyter
		nnoremap <leader>jq <cmd>lua require("python_nvim.builtin").PythonInit(4)<cr>
		vnoremap <leader>x <cmd>lua require("python_nvim.builtin").runPythonSelection(4)<cr><esc>
		nnoremap <leader>x <cmd>lua require("python_nvim.builtin").runPythonBlock(4)<cr>
		nnoremap <leader>xl <cmd>lua require("python_nvim.builtin").runPythonLineNoIndent(4)<cr>
	endif
endif

" source /home/josiah/Desktop/josiah/plover/benoit-pierre/retro_formatter_with_translations/.tox/dev/bin/activate
