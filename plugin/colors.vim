
" colorschemes
" Plug 'morhetz/gruvbox'
" gruvbox (for some reason it doesn't like this until after plug#end?

set termguicolors
let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'
try
	colorscheme gruvbox
catch
	colorscheme desert
endtry
set background=dark

" for 
if has('nvim')
	lua require'colorizer'.setup()
endif
