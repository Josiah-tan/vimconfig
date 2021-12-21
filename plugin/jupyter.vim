

function! JupyterInit()
	MagmaInit python3
	let b:jupyter_console_on = 1
endfunction

function! JupyterDeInit()
	MagmaInit python3
	let b:jupyter_console_on = 0
endfunction


" function! JupyterEvaluateVisual()
" 	if (g:jupyter_console_on) == 0
" 		call JupyterInit()
" 	endif
" 	MagmaEvaluateVisual
" endfunction
"
if g:use_magma && has('nvim')
	nnoremap <leader>jq :call JupyterInit()<CR>
	nnoremap <leader>jd :call JupyterDeInit()<CR>
	autocmd BufEnter *.* xnoremap <silent><LocalLeader>x :<C-u>MagmaEvaluateVisual<CR>
	autocmd BufEnter *.* nnoremap <silent><LocalLeader>x :MagmaReevaluateCell<CR>
	" autocmd BufEnter *.* nmap <silent><LocalLeader>x  vab:<C-u>MagmaEvaluateVisual<CR>
	autocmd BufEnter *.* nnoremap <silent><LocalLeader>xp  vap:<C-u>MagmaEvaluateVisual<CR>
	autocmd BufEnter *.* nmap <leader>xc vac:<C-u>MagmaEvaluateVisual<CR>
	autocmd BufEnter *.* nmap <leader>xo :MagmaShowOutput<CR>
	let g:magma_automatically_open_output = v:false
elseif g:use_jupyter_vim
	" Plug 'jupyter-vim/jupyter-vim'
	" Package that connects the power of jupyter and vim together
	" ':!jupyter qtconsole &'  starts the qtconsole
	" ':JupyterConnect' connects to the qtconsole

	let g:jupyter_mapkeys = 0
	autocmd BufEnter *.* nnoremap <leader>x :JupyterSendCell<CR>
	autocmd BufEnter *.* nnoremap <leader>rf :JupyterRunFile<CR>
	nnoremap <leader>jq :!jupyter qtconsole &<CR>
	nnoremap <leader>jc :JupyterConnect<CR>
	" \e makes visual select work :JupyterSendCell
	" \x runs code between ## and ##
	" \r runs the entire code file
endif
