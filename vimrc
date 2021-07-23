" ################################################################ Autoinstall Vim-plug ################################################################
" automatically installs vim-plug (for both vim and neovim)
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ################################################################ Global Plugin Management ################################################################

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
" obviously for commentary shortcuts
Plug 'tpope/vim-commentary'

"autobracket completion
Plug 'Raimondi/delimitMate'

"python code folding
Plug 'tmhedberg/SimpylFold'

"Andrew's plugins
Plug 'AndrewRadev/switch.vim'

" toggle between multiline and single line split
Plug 'andrewRadev/splitjoin.vim'

"file finding
Plug 'preservim/nerdtree'

" best colorscheme ever
Plug 'morhetz/gruvbox'

" Package that connects the power of jupyter and vim together
Plug 'jupyter-vim/jupyter-vim'

"for performing calculations on the fly
Plug 'theniceboy/vim-calc'

"for tagbar (like table of contents)
Plug 'preservim/tagbar'

" for status bar and branch
Plug 'vim-airline/vim-airline'

"for undo trees
Plug 'mbbill/undotree'

" for making aesthetic tables
Plug 'dhruvasagar/vim-table-mode'


if has('nvim')
	" ################################################################ Neovim Plugin Management ################################################################
	" neovim specific plugins

	" This is a requirement, which implements some useful window management
	"   items for neovim
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'

	" fuzzy finder etc...
	Plug 'nvim-telescope/telescope.nvim'	
	" compiled fzy sorter (hence faster)
	Plug 'nvim-telescope/telescope-fzy-native.nvim'

	" plugin for lsp configurations
	" https://microsoft.github.io/language-server-protocol/implementors/servers/
	Plug 'neovim/nvim-lspconfig'
	" for autocompletion
	Plug 'nvim-lua/completion-nvim'

	" Plugin for neovim terminals
	Plug 'ThePrimeagen/harpoon'
else
" ################################################################ Vim Plugin Management ################################################################
	" vim specific plugins
	" for fuzzy finder etc...
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	" for language server (lsp)
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

endif

" Initialize plugin system (end of plugins)
call plug#end()

" ################################################################ Global Plugin Settings ################################################################

" map <leader> to <Space>
let mapleader = " " 

" tpope stuff
" Plug 'tpope/vim-sensible'
"surrounding things with things
" Plug 'tpope/vim-surround'
" for the surround plugin repeatablility with .
" Plug 'tpope/vim-repeat'
"git integration
" Plug 'tpope/vim-fugitive' 
nnoremap <leader>gs :G<CR>
nnoremap <leader>gp :G push<CR>
" Plug 'tpope/vim-commentary'
" makes the commentary for c, cpp, css and java be automatically // instead of
" the default /* and */
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s

"autobracket completion
" Plug 'Raimondi/delimitMate'

"python code folding
" Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview = 1

"Andrew's plugins
" Plug 'AndrewRadev/switch.vim'
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

" Plug 'andrewRadev/splitjoin.vim'

"file finding
" Plug 'preservim/nerdtree'
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
" Plug 'morhetz/gruvbox'
" gruvbox (for some reason it doesn't like this until after plug#end?

let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'
colorscheme gruvbox
set background=dark


" Plug 'jupyter-vim/jupyter-vim'
" Package that connects the power of jupyter and vim together
" ':!jupyter qtconsole &'  starts the qtconsole
" ':JupyterConnect' connects to the qtconsole

nnoremap <leader>jq :!Jupyter qtconsole &<CR>
nnoremap <leader>jc :JupyterConnect<CR>
" \e makes visual select work :JupyterSendCell
" \x runs code between ## and ##
" \r runs the entire code file

" Plug 'theniceboy/vim-calc'
" now you can press \a to evaluate an expession
nnoremap <leader>a :call Calc()<CR>


" Plug 'preservim/tagbar'
" map a key to toggle the tagbar window
nmap <leader>tb :TagbarToggle<CR>

" for status bar and branch
" Plug 'vim-airline/vim-airline'

"for undo trees
" Plug 'mbbill/undotree'
if has("persistent_undo")
	" for some strange reason the undo trees for neovim and vim are incompatible
	let target_path = has('nvim') ? expand('~/.config/nvim/undodir'): expand('~/.vim/undodir')
	" let target_path =  expand('~/.vim/undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

	set noswapfile
	set nobackup
    let &undodir=target_path
    set undofile

	nnoremap <leader>ut :UndotreeToggle<CR>
endif

" for making aesthetic tables
" Plug 'dhruvasagar/vim-table-mode'

nnoremap <leader>tm :TableModeToggle<CR>
nnoremap <leader>tr :TableModeRealign<CR>
nnoremap <leader>tt :Tableize<CR>



"kite settings (for some reason kite is so dodgy that it doesn't even use vim-plug
" disabling kite
let g:kite_supported_languages = []

if has('nvim')
	" ################################################################ Neovim Plugin Settings ################################################################
	" neovim specific plugins

	" This is a requirement, which implements some useful window management
	"   items for neovim
	" Plug 'nvim-lua/popup.nvim'
	" Plug 'nvim-lua/plenary.nvim'

	" fuzzy finder etc...
	" Plug 'nvim-telescope/telescope.nvim'	
	" Plug 'nvim-telescope/telescope-fzy-native.nvim'
	" override the file and generic sorter for telescope


	lua require('telescope').setup { extensions = { fzy_native = { override_generic_sorter = false, override_file_sorter = true, } } }
	lua require('telescope').load_extension('fzy_native')


	" primeagen
	" doesn't work?
	" nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>
	

	" <C-c> exit telescope
	" Using Lua functions
	nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
	nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
	nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
	nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>


	" Custom
	nnoremap <leader>gf <cmd>lua require('telescope.builtin').git_files()<cr>
	nnoremap <leader>vr :lua require('telescope.builtin').find_files({prompt_title = "vimrc >", cwd = "~/.vim/"})<CR>

	nnoremap <leader>gd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
	nnoremap <leader>gr <cmd>lua require('telescope.builtin').lsp_references()<cr>
	nnoremap <leader>gi <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
	
	
	" plugin for lsp configurations
	" https://microsoft.github.io/language-server-protocol/implementors/servers/
	" Plug 'neovim/nvim-lspconfig'
	" pyright

	" for autocompletion
	" Plug 'nvim-lua/completion-nvim'

	let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
	lua require('lspconfig').pyright.setup{on_attach=require'completion'.on_attach}
	lua require('lspconfig').clangd.setup{on_attach=require'completion'.on_attach}

	" Plugin for neovim terminals
	" Plug 'ThePrimeagen/harpoon'
	"nice little mappings for different terminals using hjkj keys for easy navigation
	nnoremap <leader>th <cmd>lua require("harpoon.term").gotoTerminal(1)<cr>
	nnoremap <leader>tj <cmd>lua require("harpoon.term").gotoTerminal(2)<cr>
	nnoremap <leader>tk <cmd>lua require("harpoon.term").gotoTerminal(3)<cr>
	nnoremap <leader>tl <cmd>lua require("harpoon.term").gotoTerminal(3)<cr>

else
	" ################################################################ Vim Plugin Settings ################################################################
	" vim specific plugins
	" for fuzzy finder etc...
	" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	" Plug 'junegunn/fzf.vim'
	nnoremap <leader>ff :Files<cr>
	nnoremap <leader>fg :GFiles<cr>
	nnoremap <leader>fb :Buffers<cr>
	nnoremap <leader>fh :Helptags<cr>

	nmap <leader>gd <Plug>(coc-definition)
	nmap <leader>gr <Plug>(coc-references)

	" for language server (lsp)
	" Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif


"################################################################ Global General Configurations ############################################################### 


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

" Makes it so that when you scroll up/down the cursor never goes to the
" beginning of the screen, it is good for ctrl + u and ctrl + d (makes them slightly less jarring)
set scrolloff=8

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

" easy window movement
nnoremap <leader>l <C-w>l
nnoremap <leader>j <C-w>j
nnoremap <leader>h <C-w>h
nnoremap <leader>k <C-w>k


if has('nvim')
"################################################################ Neovim General Configurations ################################################################
	" neovim general configurations
	" makes it so that in insert mode the cursor remains a block
	set guicursor=
	" makes it so that after you perform a search the highlighting turns off
	set nohlsearch
	" allows for fast swapping back and forth between buffers
	set hidden

	set clipboard+=unnamedplus

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
" Python: h => heading, r => run python, p => print, b = code body, d => datascience, q => qtconsole (jupyter), t => ~/.vim/templates, n => ## code section breaks, s => symbols conversion, e => solve Eq, i => __init__ function automation
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
	let @h = 'ggO# =====================================================# File€ýaO€ýajki#€ýajA Name: €ýa"%po# Date of Creation: €ýa:put = strftime(\"%c\")kJo# Author: Josiah Tan# Description:## =====================================================# =====================================================€ýa'
	let @r = ":!python3 %\n"
	let @p = ':s/\(\s*\)\(.\+\)/\1print(f"\2 = {\2}")/j'
	let @b = "oif __name__ == '__main__':\n"
	let @d = "Oimport numpy as npimport pandas as pdimport matplotlib.pyplot as plt€ýa"
	let @t = 'O%run -n "~/.vim/templates/markdown"%run -n "~/.vim/templates/solve"€ý'
	let @n = 'o##€ý'
	let @s = '^v$hy^v$h:s/\%V /, /geA = symbols("€ýap'
	let @e = ':s/ *\(^ *\|, \) *\([^=]\{-}\)\s*= *\([^,]\)/\1Eq(\2, \3)/g|s/^\(\s*\)/\1solve([/|s/$/])/'
	let @i = '^f(yi(o":s/ *\(^ *\|, \) *\([^=,]\{-}\)\s*= *\([^,]\)/\1\2/g^dt,:s/\(\s*\), *\([^,]\+\)/\1".\2 = \2,/g0yiw:s/,/\r"/g'
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
	let @b = '@h@gi#define true 1#define false 0#define bool char€ýa'
endfunction

" .md settings
autocmd BufnewFile,BufRead,TabEnter *.md call SetMDOptions()
function SetMDOptions()
	let @u = ':s/\w\+/\u&/ge'
endfunction






