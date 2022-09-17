
if has('nvim')
	lua require("Comment").setup() 
	augroup TPOPE
		autocmd!
		autocmd FileType verilog setlocal commentstring=//\ %s
	augroup END
else
	augroup TPOPE
		autocmd!
		autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
	augroup END
end

