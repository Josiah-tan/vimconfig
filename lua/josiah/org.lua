
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.org = {
  install_info = {
    url = 'https://github.com/milisims/tree-sitter-org',
    revision = 'main',
    files = {'src/parser.c', 'src/scanner.cc'},
  },
  filetype = 'org',
}

require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = {}, -- {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

require('orgmode').setup({
	org_agenda_files = {"~/org/*"},
	org_default_notes_file = '~/org/refile.org',
	mappings = {
		org = {
			org_cycle = '<nop>',
		},
	},
	org_agenda_templates = {
		t = {
			description = 'Todo',
			template = '* TODO %?\n %u',
			target = '~/org/todo.org',
		},
		j = {
			description = 'Journal',
			template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
			target = '~/org/journal.org',
		},
	},
})

vim.g.completion_chain_complete_list = {
  org = {
    { mode = 'omni'},
  },
}
vim.cmd[[autocmd FileType org setlocal iskeyword+=:,#,+ | lua require'completion'.on_attach()]]


-- require('orgmode').setup({
--   org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
--   org_default_notes_file = '~/Dropbox/org/refile.org',
-- })

