
"file finding
" Plug 'preservim/nerdtree'
"
" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
augroup NERD_TREE
	autocmd!
	autocmd FileType nerdtree setlocal relativenumber
augroup END

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
