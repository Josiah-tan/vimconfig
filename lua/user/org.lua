-- init.lua

-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()

-- Tree-sitter configuration
require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    -- disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

-- require('orgmode').setup({
--   org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
--   org_default_notes_file = '~/Dropbox/org/refile.org',
-- })--

-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.org = {
--   install_info = {
--     url = 'https://github.com/milisims/tree-sitter-org',
--     revision = 'main',
--     files = {'src/parser.c', 'src/scanner.cc'},
--   },
--   filetype = 'org',
-- }

-- require('orgmode').setup_ts_grammar()
--
-- require'nvim-treesitter.configs'.setup {
--   -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
--   highlight = {
--     enable = true,
--     disable = {}, -- {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
--     additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
--   },
--   ensure_installed = {'org'}, -- Or run :TSUpdate org
-- }
--
require('orgmode').setup({
	org_todo_keywords = {"TODO(t)", "|", "DONE(d)", "CANCELLED(c)"},
	org_indent_mode = "noindent",
	org_agenda_files = {"~/org/*","~/org/uni/3_2/*"},
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

-- vim.g.completion_chain_complete_list = {
--   org = {
--     { mode = 'omni'},
--   },
-- }
-- vim.cmd[[autocmd FileType org setlocal iskeyword+=:,#,+ | lua require'completion'.on_attach()]]

require'cmp'.setup({
  sources = {
	    { name = 'orgmode' }
		  }
		})

-- vim.cmd[[
-- autocmd FileType org lua require'cmp'.setup.buffer {
-- \   sources = {
-- \     {name = 'orgmode'},
-- \   },
-- \ }
-- ]]

-- require'cmp'.setup({
--   sources = {
--     { name = 'orgmode' }
--   }
-- })
--
-- require('orgmode').setup({
--   org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
--   org_default_notes_file = '~/Dropbox/org/refile.org',
-- })

-- just an idea for writing new logs (and have them save without having to look into temp)
-- defined in org.lua
-- defined in org.lua
local folder = '~/org/cap/'
local tmuxSplit = function()
	-- vim.cmd([[!tmux split-window -v -p 20 "nvim -c 'lua require("user.org").customLog()' .; $SHELL"]])  -- I wish this one works
	-- vim.cmd([[!tmux split-window -v -p 20 "nvim -c 'vsplit'; $SHELL"]]) -- this one works but not what I want
	vim.fn.system([[tmux split-window -v -p 20 "nvim .; $SHELL"]])  -- finally something that actually works
end

local captionSplit = function()
	-- vim.fn.system([[tmux split-window -v -p 20 "nvim -c 'call CustomLog()' -c 'set laststatus=0' .; $SHELL"]])  -- finally something that actually works
	if vim.fn.isdirectory(vim.fn.expand(folder)) == 1 then
		local not_marked = vim.fn.system("tmux display -p -t '~' '#D'") == "no marked target\n"
		if not_marked then
			vim.fn.system([[tmux split-window -v -p 20 "tmux select-pane -m && nvim -c 'call CustomLog()' -c 'set laststatus=0' ."]])  -- finally something that actually works
		else
			local tried = vim.fn.system([[tmux join-pane -p 20 && tmux select-pane -m]])
			if tried == "can't join a pane to its own window\n" then
				vim.fn.system([[tmux select-pane -t '~']])
			end
		end
	else
		print("clone or stow (todo) your org files first man")
	end
end

local goToProgram = function()
	vim.fn.system([[tmux select-pane -t '~' && tmux select-pane -l]])
end

M = {}
M.customLog = function()
		local time = vim.fn.strftime("%Y/%b/%d")
		-- print(time)
		-- print("edit "..folder..time..".org")
		vim.cmd("edit "..folder..time..".org")
		vim.cmd("silent !mkdir -p %:h")
end

vim.keymap.set("n", "<leader>og", function ()
	M.customLog()
end)

vim.keymap.set({"n", "v"}, "<leader>ts", function ()
	tmuxSplit()
end)

vim.keymap.set({"n", "v"}, "<leader>tc", function ()
	captionSplit()
end)

vim.keymap.set({"n", "v"}, "<leader>tpr", function ()
	goToProgram()
end)

return M

