if has('nvim')
	nnoremap <leader>jq :MagmaInit python3<CR>
	" autocmd BufEnter *.* nnoremap <silent><LocalLeader>x :<C-u>MagmaEvaluateVisual<CR>
	autocmd BufEnter *.* xnoremap <silent><LocalLeader>x  :<C-u>MagmaEvaluateVisual<CR>
	autocmd BufEnter *.* nmap <silent><LocalLeader>x  vab:<C-u>MagmaEvaluateVisual<CR>
	autocmd BufEnter *.* nnoremap <silent><LocalLeader>xp  vap:<C-u>MagmaEvaluateVisual<CR>
	autocmd BufEnter *.* nmap <leader>xc vac:<C-u>MagmaEvaluateVisual<CR>
	autocmd BufEnter *.* nmap <leader>xo :MagmaShowOutput<CR>
	let g:magma_automatically_open_output = v:false
else
	" Plug 'jupyter-vim/jupyter-vim'
	" Package that connects the power of jupyter and vim together
	" ':!jupyter qtconsole &'  starts the qtconsole
	" ':JupyterConnect' connects to the qtconsole

	let g:jupyter_mapkeys = 0
	autocmd BufEnter *.* nnoremap <leader>x :JupyterSendCell<CR>
	nnoremap <leader>jq :!jupyter qtconsole &<CR>
	nnoremap <leader>jc :JupyterConnect<CR>
	" \e makes visual select work :JupyterSendCell
	" \x runs code between ## and ##
	" \r runs the entire code file
endif
