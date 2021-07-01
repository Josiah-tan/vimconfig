" put this at the beginning of the file for vim package management
execute pathogen#infect('bundle/{}', '~/src/vim/bundle/{}') 
"
" turn on syntax highlighting
syntax on 
"file type detection
filetype plugin indent on 

" tells you which line number u r at
set number
" tells you the relative numbers of lines above and below the cursor
set relativenumber

"to automatically indent newlines
set autoindent
"reacts to the code syntax
set smartindent

"sets tabs to be n number of spaces
set shiftwidth=4
"sets number of spaces that a tab character in the file counts for
set tabstop=4

" Indents word-wrapped lines as much as the 'parent' line
set breakindent
" Ensures word-wrap does not split words
set formatoptions=l
set lbr

" Have Vim jump to the last position when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Do case insensitive matching
set ignorecase
" Do smart case matching
set smartcase

" Automatically save before commands like :next and :make
set autowrite

" Makes increments and decrements available for letters
set nrformats+=alpha

" saves code folding 
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview


"gruvbox settings
colorscheme gruvbox
set background=dark



"youCompleteMe settings 
" don't call youCompleteMe when editing the vimrc file
autocmd BufnewFile,BufRead,TabEnter vimrc let g:ycm_auto_trigger=0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_global_ycm_extra_conf = '/home/josiah/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
" disable ycm for python when using kite instead
let g:ycm_filetype_blacklist = {
			\ 'python' : 1,
			\}

"kite settings
let g:kite_supported_languages = ['python']

" WSL yank support - also this if statement below is used to store all the WSL configs (seperate from my linux virtual machine)
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
	" make the color scheme nice
	color industry
	" this is for disabling YCM in situations such as when using codewarrier
	" (which uses a different compiler than clang)
	let g:ycm_show_diagnostics_ui = 1
	let g:ycm_enable_diagnostic_signs = 0 
	let g:ycm_enable_diagnostic_highlighting = 0

	" the stuff required to make yanking to the system clipboard work
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif



" Prerecorded macro settings for registers
" Python macro settings
autocmd BufnewFile,BufRead,TabEnter *.py call SetPythonOptions()
function SetPythonOptions()
	let @h = 'ggO# =====================================================# File€ýaO€ýajki#€ýajA Name: €ýa"%po# Date of Creation: €ýa:put = strftime(\"%c\")kJo# Author: Josiah Tan# Description:## =====================================================# =====================================================€ýa'
	let @r = ":!python3 %\n"
	let @p = ':s/.\+/print(f"& = {&}")/j'
	let @b = "oif __name__ == '__main__':\n"
	let @d = "Oimport numpy as npimport pandas as pdimport matplotlib.pyplot as plt€ýa"
	let @q = ":!jupyter qtconsole &:JupyterConnect"
	let @t = 'O%run -n "~/.vim/templates/markdown"%run -n "~/.vim/templates/solve"€ý'
	let @n = 'o##€ý'
	let @s = '^v$hy:s/ /, /geA = symbols("€ýap'
endfunction

" Global C family settings for header, c and cpp files
autocmd BufnewFile,BufRead,TabEnter *.c,*.cpp,*.h call SetCFamGlobalOptions()
function SetCFamGlobalOptions()
	let @h = 'ggO/* File Name: €ýa"%po Date of Creation: €ýa:put = strftime(\"%c\")kJoAuthor: Josiah TanDescription: €kb€kb€kb€kb€kb*/€ýa'
	let @t = 'Sfor (int t=0;t<T;t++){€ýaO€ýa'
	let @i = 'Sfor (int i=0;i<n;i++){€ýaO€ýa'
	let @j = 'Sfor (int j=0;j<m;j++){€ýaO€ýa'
	let @k = 'Sfor (int k=0;k<l;k++){€ýaO€ýa'
	let @f = '$F(yi)O/*Description: 	p€kbParameters:	€ýap:s/, /:  *		/geA:€kbReturns:€ýajf€ýa$F(Bhy^kA		€ýapA: €kb€kb€kb€kb*/€ýao€ýa?DescriptionA€ýa'
endfunction

" c settings
autocmd BufnewFile,BufRead,TabEnter *.c call SetCOptions()
function SetCOptions()
	let @r = ":!gcc % && ./a.out\n"
	let @b = 'i#include<stdio.h>#include<stdlib.h>#include<limits.h>int main(void){€ýaOretrnreturn 0;€ýak'
	" let @m = 
endfunction

" cpp settings
autocmd BufnewFile,BufRead,TabEnter *.cpp call SetCPPOptions()
function SetCPPOptions()
	let @r = ":!g++ % && ./a.out\n"
	let @b = 'i#include<iostream>#include<c€kbvector>#include<alsotalgorithm>@€kb#include<climits>#include<string>€kb€kb€kb€kb€kb€kb€kb€kbit €kb€kbnt main(void){€ýaOreturn 0;€ýakkOusing namespace std;€ýa3jOint T; €kbcin >> T;for (int i€kbt=1;t<=T;t++){€ýaOcout << "Case #" << t << ans << endl;€ýaOans = 0;€ýaIint €ýa'
	" let @m = 
	let @p = '^v$hdacout << "€ýapA << €ýapA << end;€kbl;€ýaj'
endfunction

" .h settings
autocmd BufnewFile,BufRead,TabEnter *.h call SetHOptions()
function SetHOptions()
	let @g = '€ýa"%p:s/\(\w\+\)\.\(\w\)/#ifndef \U\1_\U\2\e\r#define \U\1_\U\2/G10o€ýaI#endif€ýa2j'
endfunction


" vim macros documentation
" General: v => overwrite the original vim file
"
" Python: h => heading, r => run python, p => print, b = code body, d => datascience, q => qtconsole (jupyter), t => ~/.vim/templates, n => ## code section breaks, s => symbols conversion
"
" CFam: h => heading, r => run (gcc/++ main.c && ./a.out), m => make (template with src and header files (todo) ), b => code body , p => print (only for c++)
" for loops <= (t, i, j, k), f => function commentary
"
" Header: g = guard headers
"



"switch.vim plugin settings
" let g:switch_mapping = "-"
let g:variable_style_switch_definitions = [
      \   {
      \     '\<[a-z0-9]\+_\k\+\>': {
      \       '_\(.\)': '\U\1'
      \     },
      \     '\<[a-z0-9]\+[A-Z]\k\+\>': {
      \       '\([A-Z]\)': '_\l\1'
      \     },
      \   }
      \ ]
nnoremap + :call switch#Switch({'definitions': g:variable_style_switch_definitions})<cr>
nnoremap - :Switch<cr>




"NERDTree plugin settings
"
" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

"re/opens nerdtree + mv cursor to the nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
"
"creates a nerd tree for the current directory as root (may not neccesarily be
"the directory of the file opened up by the tab)
nnoremap <C-n> :NERDTree<CR> 
"
" If the nerdtree already exists, it is reopened and rendered again. If no
" nerdtree exists, runs same as :NERDTree command
" already mapped to creating new tabs in linux (notice this)
nnoremap <C-t> :NERDTreeToggle<CR> 
"
" find and reveal the file for the active buffer in the nerdtree window as
" spec path (superior to the :NERDTree command)
nnoremap <C-f> :NERDTreeFind<CR>



"tpope/vim-commentary
" makes the commentary for c, cpp, css and java be automatically // instead of
" the default /* and */
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s



"jupyter-vim/jupyter-vim
" Package that connects the power of jupyter and vim together
" ':!jupyter qtconsole &'  starts the qtconsole
" ':JupyterConnect' connects to the qtconsole
" \e makes visual select work :JupyterSendCell
" \x runs code between ## and ##
" \r runs the entire code file



"vim-calc
" now you can press \a to evaluate an expession
nnoremap <LEADER>a :call Calc()<CR>

