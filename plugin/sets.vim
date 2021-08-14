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

" error bells, get rid of that
set noerrorbells

"for linting and lsp errors
set signcolumn=yes

" vimvscode battle settings
" this makes it so that markdown ** for bold and * for italics are not shown
" set conceallevel=2
" set norelativenumber

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
