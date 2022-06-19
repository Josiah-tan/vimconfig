
" for plover clippy
" how frequently the screen is reloaded
let g:ploverUpdateTimer = 200
" 1 => autoscroll to end of file, 0 => not autoscroll
let g:ploverAutoEOF = 1
" there are 3 positioning options: centre, bottom, top
" let g:ploverAutoPosition = "centre"
let g:ploverAutoPosition = "bottom"

let g:ploverEnableByDefault = 1

let g:PloverDisableRemaps = 0

" for plover in general

nore <c-j> <nop>
inore <c-j> <c-\><c-o>
" make undo work in insert mode
inore <c-j>u <esc>u
" does not work for some reason
" inore <c-j>. <esc>.
cnoremap <c-j> <esc>

if !has('nvim')
	set termwinkey=<c-j>
else
	tnoremap <c-j> <C-\><C-n>
endif

" let g:EasyMotion_keys = 'bdfgjklmnprstxz'
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'

