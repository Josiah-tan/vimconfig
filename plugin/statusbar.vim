" \ [ 'fileformat', 'fileencoding', 'filetype'],
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
					\ ['charvaluehex' ],
					\ ['shrinkFiletype'],
					\ ['shrinkFileencoding'],
					\ ['shrinkFileformat'],
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
				\ 'funmessage': 'LightLineFunMessage',
				\ 'shrinkFiletype' : 'LightLineShrinkFiletype',
				\ 'shrinkFileencoding' : 'LightLineShrinkFileencoding',
				\ 'shrinkFileformat' : 'LightLineShrinkFileFormat',
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
	if winwidth(0) > 100 && len(l:filePath) < winwidth(0) / 2
		return l:filePath
	else
		return pathshorten(l:filePath)
	endif
endfunction

function! LightLineFunMessage()
	if winwidth(0) > 100 
		return 'nvim is cool'
	else 
		return ''
	endif
endfunction

function! LightLineShrinkFiletype()
	if winwidth(0) > 100 
		return &filetype
	else 
		return ''
	endif
endfunction

function! LightLineShrinkFileencoding()
	if winwidth(0) > 100 
		return &fileencoding
	else 
		return ''
	endif
endfunction

function! LightLineShrinkFileFormat()
	if winwidth(0) > 100 
		return &fileformat
	else 
		return ''
	endif
endfunction
