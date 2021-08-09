if has('nvim')
	lua package.loaded['josiah.internet'] = nil
	lua require('josiah.internet')

	nnoremap <leader>gx <cmd>lua RELOAD("josiah.internet").linkUnderCursor()<cr>
end
