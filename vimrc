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

"youCompleteMe settings 
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




" viminfo setting for customised prerecorded macros for registers to specific files (*.c, *.py, etc)
" autocmd BufnewFile,BufRead,TabEnter *.py :rv! ~/.vim/info/.pyinfo.vim
autocmd BufnewFile,BufRead,TabEnter *.py call SetPythonOptions()
function SetPythonOptions()
	let @h = 'ggO# ++€kb€kb=======================================================€kb€kb# File€ýaO€ýajki#€ýajA Name: €ýa:let %€kb@" = expand("%")po#d€kb Date of Creation: €ýa:put = defstrtimefstrtftimstrftime(\"%c\")kJo# Author: Josiah Tan# Description:3€kb€kb## =====================================================# =====================================================€ýa'
	let @r = ":!python3 %\n"
	let @p = '^d$aprint(f"€ýapa = {€ýapf)i"€ýaA;€ýa'
	let @b = "oif __name__ == '__main__':\n"
	let @d = "Oimport numpy as npimport pandas as pdimport matplotlib.pyplot as plt€ýa"
	let @q = ":!jupyter qtconsole &:JupyterConnect"
	let @t = 'O%run -n "~/.vim/templates/markdown"%run -n "~/.vim/templates/solve"€ý'
	let @n = 'o##€ý'
	let @s = '^v$hy:s/ /, /geA = symbols("€ýap'
endfunction

autocmd BufnewFile,BufRead,TabEnter *.c :rv! ~/.vim/info/.cinfo.vim
autocmd BufnewFile,BufRead,TabEnter *.cpp :rv! ~/.vim/info/.cppinfo.vim
autocmd BufnewFile,BufRead,TabEnter *.h :rv! ~/.vim/info/.hinfo.vim

" vim info documentation
" General: v => overwrite the original vim file
"
" ~/.pyinfo.vim: h => heading, r => run python, p => print, b = code body, d => datascience, q => qtconsole (jupyter), t => ~/.vim/templates, n => ## code section breaks, s => symbols conversion
"
" ~/.cinfo.vim: h => heading, r => run (g++ main.c && ./a.out), m => make (template with src and header files (todo) ), b => code body 
" for loops <= (t, i, j, k ), f => function commentary
"
" ~/.hinfo.vim: h => heading, g = guard headers, f => function commentary
"



"switch.vim plugin settings
let g:switch_mapping = "-"



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

