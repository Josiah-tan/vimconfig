
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
					\ [ 'gitbranch', 'readonly', 'filename', 'modified', 'funmessage']],
			\ },
			\ 'component': {
				\ 'funmessage': 'Best Editor = nvim',
				\ 'charvaluehex': '0x%B'
			\ },
			\ 'component_function': {
				\ 'gitbranch' : 'FugitiveHead'
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


