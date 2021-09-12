

" let g:enable_quick_projects_default_mappings = 1

" this is for the quick projects plugin development 
" set rtp+=~/Desktop/josiah/neovim/quick_projects/

if has('nvim')
	nnoremap <leader>qp <cmd>lua RELOAD('quick_projects.builtins').quickProjects()<cr>
end

