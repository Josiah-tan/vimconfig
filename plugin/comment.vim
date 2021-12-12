
if has('nvim')
	lua require("Comment").setup() 
else
	augroup TPOPE
		autocmd!
		autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
	augroup END
end

