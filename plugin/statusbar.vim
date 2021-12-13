
" \ 'left': [ [ 'mode', 'paste' ],
" \ ['readonly', 'filename', 'modified', 'funmessage']],
" \},
" \ 'funmessage': 'Vim Is The Best',
set noshowmode
let g:lightline = {
			\ 'colorscheme': 'one',
			\ 'active': {
				\ 'right': [ 
					\[ 'lineinfo' ],
					\ [ 'percent' ],
					\ [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ],
					\ ],
				\ 'left': [ 
					\[ 'mode', 'paste' ],
					\ [ 'gitbranch', 'readonly', 'modified', 'truncatedFileName', 'funmessage']],
			\ },
			\ 'component': {
				\ 'charvaluehex': '0x%B'
			\ },
			\ 'component_function': {
				\ 'gitbranch' : 'FugitiveHead',
				\ 'truncatedFileName': 'LightLineTruncatedFileName',
				\ 'funmessage': 'LightLineFunMessage'
			\ },
		   \ 'mode_map': {
			 \ 'n' : 'N',
			 \ 'i' : 'I',
			 \ 'R' : 'R',
			 \ 'v' : 'V',
			 \ 'V' : 'VL',
			 \ "\<C-v>": 'VB',
			 \ 'c' : 'C',
			 \ 's' : 'S',
			 \ 'S' : 'SL',
			 \ "\<C-s>": 'SB',
			 \ 't': 'T',
			 \ },
			\ }

function! LightLineTruncatedFileName()
let l:filePath = expand('%')
    if winwidth(0) > 100
        return l:filePath
    else
        return pathshorten(l:filePath)
    endif
endfunction

function! LightLineFunMessage()
 if winwidth(0) > 100 
	 return 'Best Editor = nvim'
 else 
	 return ''
endfunction
