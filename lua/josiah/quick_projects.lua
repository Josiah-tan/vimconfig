
-- Plug 'Josiah-tan/quick_projects'

require('quick_projects').setup(
{
	debug_mode_on = true,
	enable_global_mappings = false,
})

require('quick_projects').setup(
{
	builtin_defaults = {
		cwd = "~/.config/.quick_projects/",
	}
})

require('quick_projects').setup(
{
	builtin_defaults = {
		cwd = "~/.config/.quick_projects/",
		quickProjects = {
			prompt_title =  "quick projects >",
			dir = "projects",
		},
	}
})


require('quick_projects').setup(
{
	builtin_defaults = {
		generalMarks = {
			dir = "marks",
			file = "marks.txt",
			split_character = "@",
		},
	}
})

require('quick_projects').setup(
{
	builtin_defaults = {
		quickMarks = {
			prompt_title =  "quick marks >",
		},
	}
})

require('quick_projects').setup(
{
	builtin_defaults = {
		mappings = {
			{
				mode = 'i',
				key = '<C-s>',
				attempt_vim_session = true,
				tmux = {
					enable = true,
				},
				linux_terminal = {
					enable = true,
					use_tabs = true,
				}
			},
			{
				mode = 'i',
				key = '<C-t>',
				attempt_vim_session = false,
				tmux = {
					enable = true,
				},
				linux_terminal = {
					enable = true,
					use_tabs = true,
				}
			},
			{
				mode = 'i',
				key = [[<M-m>]],
				attempt_vim_session = true,
				tmux = {
					enable = false,
					add_mark = true
				},
				linux_terminal = {
					enable = false,
					use_tabs = true,
				}
			}}


	}
})

require('quick_projects').setup(
{
	builtin_defaults = {
		navMark = {
			idx = 1,
			attempt_vim_session = true,
			tmux = {
				enable = true,
			},
			linux_terminal = {
				enable = true,
				use_tabs = false,
			}
		},
	}
})


vim.api.nvim_set_keymap("n", "<Leader>qp", [[ <Esc><Cmd>lua RELOAD('quick_projects.builtins').quickProjects()<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>qm", [[ <Esc><Cmd>lua RELOAD('quick_projects.builtins').quickMarks()<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>qj", [[ <Esc><Cmd>lua RELOAD('quick_projects.builtins').navMark({idx = 1})<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>qk", [[ <Esc><Cmd>lua RELOAD('quick_projects.builtins').navMark({idx = 2})<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>ql", [[ <Esc><Cmd>lua RELOAD('quick_projects.builtins').navMark({idx = 3})<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<Leader>q;", [[ <Esc><Cmd>lua RELOAD('quick_projects.builtins').navMark({idx = 4})<CR>]], {noremap = true, silent = true, expr = false})

vim.cmd [[autocmd User TelescopePreviewerLoaded setlocal wrap]]
