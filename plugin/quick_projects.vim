

" let g:enable_quick_projects_default_mappings = 1

" this is for the quick projects plugin development 
" set rtp+=~/Desktop/user/neovim/quick_projects/

if has('nvim')
	" nnoremap <leader>qp <cmd>lua RELOAD('quick_projects.builtins').quickProjects()<cr>
	lua require('user.quick_projects')

end
