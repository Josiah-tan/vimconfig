" stuff from tjdevries, telescopic johnson devries
" s = for this script only, abort means exit function if there are any errors
function! s:executor() abort
	if &ft == 'lua'
		call execute(printf(":lua %s", getline(".")))
	elseif &ft == 'vim' || expand("%:t") == 'vimrc'
		exe getline(".")
		"  for some reason this one doesn't work?
		" exe getline(">")
	endif
endfunction

augroup EXECUTORS
	autocmd!
	" autocmd BufEnter *.* nnoremap <leader>x :JupyterSendCell<CR>
	autocmd BufEnter *.vim,*.lua,vimrc nnoremap <leader>x :call <SID>executor()<CR>
	autocmd BufEnter *.vim,*.lua,vimrc vnoremap <leader>x :<C-w>exe join(getline("'<","'>"), '<Bar>')<CR>
augroup END

function! s:save_and_exec() abort
	if &filetype == 'vim' || expand("%:t") == 'vimrc'
		:silent! write
		:source %
	elseif &filetype == 'lua'
		:silent! write
		:luafile %
	endif
	"note that this return statement is actually important
	return 
endfunction

nnoremap <leader><leader>x :call <SID>save_and_exec()<CR>
