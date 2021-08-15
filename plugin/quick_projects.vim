
" let g:enable_quick_projects_default_mappings = 1

if has('nvim')
	nnoremap <leader>qp <cmd>lua require('quick_projects.builtins').quickProjects()<cr>
end
