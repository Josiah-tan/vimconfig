

" let g:enable_quick_projects_default_mappings = 1

" this is for the quick projects plugin development (it doesn't source the quick_projects after a terminal is made, a very unique problem to this plugin!)
set rtp+=~/Desktop/josiah/neovim/quick_projects/

if has('nvim')
	nnoremap <leader>qp <cmd>lua require('quick_projects.builtins').quickProjects()<cr>
end

