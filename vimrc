" ################################################################ Autoinstall Vim-plug ################################################################
" automatically installs vim-plug (for both vim and neovim)
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ################################################################ Global Plugin Settings ################################################################

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - For vim: '~/.vim/plugged'
" - Avoid using standard Vim directory names like 'plugin'
let plugin_dir_plug = has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged'
call plug#begin(plugin_dir_plug)

" tpope stuff
Plug 'tpope/vim-sensible'
"surrounding things with things
Plug 'tpope/vim-surround'
" for the surround plugin repeatablility with .
Plug 'tpope/vim-repeat'
"git integration
Plug 'tpope/vim-fugitive' 
Plug 'tpope/vim-commentary'
" makes the commentary for c, cpp, css and java be automatically // instead of
" the default /* and */
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s

"autobracket completion
Plug 'Raimondi/delimitMate'

"python code folding
Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview = 1

"Andrew's plugins
Plug 'AndrewRadev/switch.vim'
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

Plug 'andrewRadev/splitjoin.vim'

"file finding
Plug 'preservim/nerdtree'
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

" colorschemes
Plug 'morhetz/gruvbox'


Plug 'jupyter-vim/jupyter-vim'
" Package that connects the power of jupyter and vim together
" ':!jupyter qtconsole &'  starts the qtconsole
" ':JupyterConnect' connects to the qtconsole
" \e makes visual select work :JupyterSendCell
" \x runs code between ## and ##
" \r runs the entire code file

Plug 'theniceboy/vim-calc'
" now you can press \a to evaluate an expession
nnoremap <LEADER>a :call Calc()<CR>


Plug 'preservim/tagbar'
" map a key to toggle the tagbar window
nmap <F8> :TagbarToggle<CR>

" for status bar and branch
Plug 'vim-airline/vim-airline'

"kite settings (for some reason kite is so dodgy that it doesn't even use vim-plug
let g:kite_supported_languages = ['python']

if has('nvim')
" ################################################################ Neovim Plugin Settings ################################################################
	" neovim specific plugins

else
" ################################################################ Vim Plugin Settings ################################################################
	" vim specific plugins

endif

" Initialize plugin system (end of plugins
call plug#end()


" ################################################################ Global General Configurations  ################################################################

" gruvbox (for some reason it doesn't like this until after plug#end?
colorscheme gruvbox
set background=dark

" tells you which line number 
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

" error bells, get rid of that
set noerrorbells

"for linting and lsp errors
set signcolumn=yes

" vimvscode battle settings
" this makes it so that markdown ** for bold and * for italics are not shown
set conceallevel=2
" set norelativenumber


if has('nvim')
" ################################################################ Neovim General Configurations ################################################################
	" neovim general configurations
	" makes it so that in insert mode the cursor remains a block
	set guicursor=
	" makes it so that after you perform a search the highlighting turns off
	set nohlsearch
	" allows for fast swapping back and forth between buffers
	set hidden
else
" ################################################################ Vim General Configurations ################################################################
	" vim general configurations

	" turn on syntax highlighting
	syntax on 
	"file type detection
	filetype plugin indent on 

endif

" ################################################################ WSL General Configurations ################################################################

" WSL yank support - also this if statement below is used to store all the WSL configs (seperate from my linux virtual machine)
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
	" the stuff required to make yanking to the system clipboard work
	augroup WSLYank
		autocmd!
		autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
	augroup END
endif

" ################################################################ Global Macro Configurations  ################################################################

" vim macros documentation
"
" Python: h => heading, r => run python, p => print, b = code body, d => datascience, q => qtconsole (jupyter), t => ~/.vim/templates, n => ## code section breaks, s => symbols conversion, e => solve Eq
"
" CFam: h => heading, r => run (gcc/++ main.c && ./a.out), m => make (template with src and header files (todo) ), b => code body/ boolean.h (.h), p => print (only for c++)
" for loops <= (t, i, j, k), f => function commentary
"
" Header: g = guard headers
"
" Markdown: u = upper first letter of each word
" vim settings 

" Prerecorded macro settings for registers
" Python macro settings
autocmd BufnewFile,BufRead,TabEnter *.py call SetPythonOptions()
function SetPythonOptions()
	let @h = 'ggO# =====================================================# File��aO��ajki#��ajA Name: ��a"%po# Date of Creation: ��a:put = strftime(\"%c\")kJo# Author: Josiah Tan# Description:## =====================================================# =====================================================��a'
	let @r = ":!python3 %\n"
	let @p = ':s/\(\s*\)\(.\+\)/\1print(f"\2 = {\2}")/j'
	let @b = "oif __name__ == '__main__':\n"
	let @d = "Oimport numpy as npimport pandas as pdimport matplotlib.pyplot as plt��a"
	let @q = ":!jupyter qtconsole &:JupyterConnect"
	let @t = 'O%run -n "~/.vim/templates/markdown"%run -n "~/.vim/templates/solve"��'
	let @n = 'o##��'
	let @s = '^v$hy^v$h:s/\%V /, /geA = symbols("��ap'
	let @e = ':s/ *\(^ *\|, \) *\([^=]\{-}\)\s*= *\([^,]\)/\1Eq(\2, \3)/g|s/^\(\s*\)/\1solve([/|s/$/])/'
endfunction

" Global C family settings for header, c and cpp files
autocmd BufnewFile,BufRead,TabEnter *.c,*.cpp,*.h call SetCFamGlobalOptions()
function SetCFamGlobalOptions()
	let @h = 'ggO/* File Name: ��a"%po Date of Creation: ��a:put = strftime(\"%c\")kJoAuthor: Josiah TanDescription: �kb�kb�kb�kb�kb*/��a'
	let @t = 'Sfor (int t=0;t<T;t++){��aO��a'
	let @i = 'Sfor (int i=0;i<n;i++){��aO��a'
	let @j = 'Sfor (int j=0;j<m;j++){��aO��a'
	let @k = 'Sfor (int k=0;k<l;k++){��aO��a'
	let @f = '$F(yi)O/*Description: 	p�kbParameters:	��ap:s/, /:  *		/geA:�kbReturns:��ajf��a$F(Bhy^kA		��apA: �kb�kb�kb�kb*/��ao��a?DescriptionA��a'
endfunction

" c settings
autocmd BufnewFile,BufRead,TabEnter *.c call SetCOptions()
function SetCOptions()
	let @r = ":!gcc % && ./a.out\n"
	let @b = 'i#include<stdio.h>#include<stdlib.h>#include<limits.h>int main(void){��aOretrnreturn 0;��ak'
	" let @m = 
endfunction

" cpp settings
autocmd BufnewFile,BufRead,TabEnter *.cpp call SetCPPOptions()
function SetCPPOptions()
	let @r = ":!g++ % && ./a.out\n"
	let @b = 'i#include<iostream>#include<c�kbvector>#include<alsotalgorithm>@�kb#include<climits>#include<string>�kb�kb�kb�kb�kb�kb�kb�kbit �kb�kbnt main(void){��aOreturn 0;��akkOusing namespace std;��a3jOint T; �kbcin >> T;for (int i�kbt=1;t<=T;t++){��aOcout << "Case #" << t << ans << endl;��aOans = 0;��aIint ��a'
	" let @m = 
	let @p = '^v$hdacout << "��apA << ��apA << end;�kbl;��aj'
endfunction

" .h settings
autocmd BufnewFile,BufRead,TabEnter *.h call SetHOptions()
function SetHOptions()
	let @g = '��a"%p:s/\(\w\+\)\.\(\w\)/#ifndef \U\1_\U\2\e\r#define \U\1_\U\2/G10o��aI#endif��a2j'
	let @b = '@h@gi#define true 1#define false 0#define bool char��a'
endfunction

" .md settings
autocmd BufnewFile,BufRead,TabEnter *.md call SetMDOptions()
function SetMDOptions()
	let @u = ':s/\w\+/\u&/ge'
endfunction






