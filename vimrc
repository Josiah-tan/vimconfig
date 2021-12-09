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

" for easy motion
Plug 'easymotion/vim-easymotion'

"autobracket completion
Plug 'Raimondi/delimitMate'

"python code folding
" Plug 'tmhedberg/SimpylFold'

"Andrew's plugins
Plug 'AndrewRadev/switch.vim'

" toggle between multiline and single line split
Plug 'andrewRadev/splitjoin.vim'

"file finding
Plug 'preservim/nerdtree'

" best colorscheme ever
Plug 'morhetz/gruvbox'


"for performing calculations on the fly
" Plug 'theniceboy/vim-calc'

"for tagbar (like table of contents)
" Plug 'preservim/tagbar'

" for status bar and branch
" Plug 'vim-airline/vim-airline'
Plug 'itchyny/lightline.vim'

"for undo trees
Plug 'mbbill/undotree'

" for making aesthetic tables
" Plug 'dhruvasagar/vim-table-mode'

" for latex
" Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" for plover
Plug 'Josiah-tan/vim-plover-clippy'

if has('nvim')
	" ################################################################ Neovim Plugin Management ################################################################
	" neovim specific plugins
	" cheetsheet for finding the keys that have been mapped?
	" Plug 'sudormrfbin/cheatsheet.nvim'

	" for syntax highlighting and refractor.nvim
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
	Plug 'nvim-treesitter/playground'
	Plug 'nvim-treesitter/nvim-treesitter-textobjects'

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

	" interesting plugin if bored
	Plug 'ThePrimeagen/vim-be-good'

	"Plugin for refractoring goodness
	Plug 'ThePrimeagen/refactoring.nvim'

	"Plugin for quick_projects
	Plug 'Josiah-tan/quick-projects-nvim'

	"Plugin for jupyter with neovim
	Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }

	"Plugin for neovim with org mode
	Plug 'nvim-orgmode/orgmode'
else
" ################################################################ Vim Plugin Management ################################################################
	" vim specific plugins
	" for fuzzy finder etc...
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	" for language server (lsp)
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

	" Package that connects the power of jupyter and vim together
	Plug 'jupyter-vim/jupyter-vim'
endif

" Initialize plugin system (end of plugins)
call plug#end()

" ################################################################ Global Plugin Settings ################################################################

" map <leader> to <Space>
let mapleader = " " 
let maplocalleader = " " 

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
nnoremap <leader>gl :G pull<CR>
" Plug 'tpope/vim-commentary'
" makes the commentary for c, cpp, css and java be automatically // instead of
" the default /* and */

augroup TPOPE
	autocmd!
	autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s
augroup END

" Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0 " Disable default mappings
map <leader><leader>. <Plug>(easymotion-repeat)
map <leader><leader>f <Plug>(easymotion-overwin-f)
" map <leader><leader>j <Plug>(easymotion-overwin-line)
" map <leader><leader>k <Plug>(easymotion-overwin-line)

"autobracket completion
" Plug 'Raimondi/delimitMate'
au FileType tex let b:delimitMate_quotes = "\" ' $"

"python code folding
" Plug 'tmhedberg/SimpylFold'
" let g:SimpylFold_docstring_preview = 1

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

" for getting fresh reads from loading a module
autocmd FileType vim,lua let b:switch_custom_definitions =
	\ [
	\ 	{
	\ 		'RELOAD': 'require',
	\ 		'require': 'RELOAD'
	\	}
	\ ]
nnoremap + :call switch#Switch({'definitions': g:variable_style_switch_definitions})<cr>
nnoremap - :Switch<cr>

" Plug 'andrewRadev/splitjoin.vim'





" Plug 'theniceboy/vim-calc'
" now you can press \a to evaluate an expession
" nnoremap <leader>a :call Calc()<CR>


" Plug 'preservim/tagbar'
" map a key to toggle the tagbar window
" nnoremap <leader>tb :TagbarToggle<CR>

" for status bar and branch
" Plug 'vim-airline/vim-airline'

" for making aesthetic tables
" Plug 'dhruvasagar/vim-table-mode'

" nnoremap <leader>tm :TableModeToggle<CR>
" nnoremap <leader>tr :TableModeRealign<CR>
" nnoremap <leader>tt :Tableize<CR>

" for latex
" Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
" let g:livepreview_previewer = 'evince'





"################################################################ Global General Autocmd ############################################################### 

function! s:changeWorkingDirectory() abort
	" changes the current working directory to be that of the file
	:cd %:h
endfunction

augroup GENERAL_CONFIG
	autocmd!
	" Have Vim jump to the last position when reopening a file
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
	" saves code folding 
	autocmd BufWinLeave *.* mkview
	autocmd BufWinEnter *.* silent! loadview
	" autocmd BufWinEnter *.lua,*.vim call ChangeWorkingDirectory()
augroup END

"################################################################ Global General Remaps ############################################################### 

"correct spelling error from 'making your first plug-in'
" looks backwards for spelling error corrects it and then goes back to the original position
function! TurnOnSpelling()
	setlocal spell spelllang=en_au
endfunction

function! CorrectSpellingError()
	call TurnOnSpelling()
	normal! mm[s1z=`m
	if &ft != 'tex'
		setlocal nospell spelllang=en_au
	endif
endfunction
nnoremap <leader>sp  :call CorrectSpellingError()<cr>
inoremap <C-l>  <Esc>:call CorrectSpellingError()<cr>a

" turn on autospell checker for .tex files
autocmd BufEnter *.tex :call TurnOnSpelling()

" easy window movement
nnoremap <leader>wl <C-w>l
nnoremap <leader>wj <C-w>j
nnoremap <leader>wh <C-w>h
nnoremap <leader>wk <C-w>k

"yank to the end of the line, not the entire line
nnoremap Y y$

"keeping it centered 
" I don't like this one so much
" nnoremap n nzzzv 
" I don't like this one so much
" nnoremap N Nzzzv
nnoremap J mzJ`z

" undo break points, everytime you type these letters you are able to undo at each of these points, rather than having something that overundos everything

inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u


" note that these break delimitmate
" inoremap [ [<c-g>u
" inoremap { {<c-g>u

" jumplist mutations (adds to jumplist if relativenumber jump is greater than 5)
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" moving text
" end of visual selection, '>+1 move text down, gv previous highlight, = fix indent, gv highlight again
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv




if has('nvim')
	" just requires in some nice globals to use
	lua require("josiah.globals");
end

" ################################################################ WSL General Configurations ################################################################

" WSL yank support - also this if statement below is used to store all the WSL configs (seperate from my linux virtual machine)
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
	" the stuff required to make yanking to the system clipboard work
	augroup WSLYank
		autocmd!
		autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
	augroup END

	" let g:netrw_browsex_viewer = 'xdg-open'
	map gx <Nop>
endif

