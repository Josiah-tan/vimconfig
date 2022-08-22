if has('nvim')
	lua package.loaded['user.internet'] = nil
	lua require('user.internet')

	nnoremap <leader>gx <cmd>lua RELOAD("user.internet").linkUnderCursor()<cr>
end
