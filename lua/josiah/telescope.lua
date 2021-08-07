local actions = require("telescope.actions")
require('telescope').setup {
	defaults = {
		file_sorter = require('telescope.sorters').get_fzy_sorter,
		prompt_prefix = ' >',
		color_devicons = true,

		file_previewer = require('telescope.previewers').vim_buffer_cat.new,
		grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
		qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

		mappings = {
			i = {
				["<C-x>"] = false,
				["<C-q>"] = actions.send_to_qflist,
			},
		}
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		}
	}
}

require('telescope').load_extension('fzy_native')

local M = {}

M.searchDotfiles = function()
	require("telescope.builtin").find_files({
		prompt_title =  "vimrc >",
		cwd = "~/.vim/",
	})
end

M.buffers = function()
	require("telescope.builtin").buffers({
		attach_mappings = function(prompt_bufnr, map)
			map('i', '<c-d>', actions.delete_buffer)
			map('n', '<c-d>', actions.delete_buffer)
			return true
		end
	})
end

M.gitBranches = function()
	require("telescope.builtin").git_branches({
		attach_mappings = function(prompt_bufnr, map)
			map('i', '<c-d>', actions.git_delete_branch)
			map('n', '<c-d>', actions.git_delete_branch)
			return true
		end
	})
end

M.liveGrep = function()
	require("telescope.builtin").grep_string({
		 search = vim.fn.input("Grep For > ")
	})
end



local function makeDir(project_dir)
    	-- every number is "truthy" so 0 = true
	local make_dir = ""
	if vim.fn.isdirectory(vim.fn.expand(project_dir)) == 0 then
		make_dir = "mkdir -p " .. project_dir .. "; "
	end
    return make_dir
end


local function nvimOpenMode(open_session, project_dir)
    	local nvim_open_mode = ""
	local sess = project_dir .. "Session.vim"
	if vim.fn.filereadable(sess) and open_session then
		nvim_open_mode = "-S Session.vim"
	else
		nvim_open_mode = "."
	end
    return nvim_open_mode
end


local function tmuxSystemCmd(use_tabs, open_session, project_dir)
	local tab = ""
	if use_tabs then
		tab = "w -n "
	else
		tab = "-session -d -s "
	end

	local make_dir = makeDir(project_dir)
	local nvim_open_mode = nvimOpenMode(open_session, project_dir)

	return "tmux new" .. tab .. "\"" .. project_dir .. "\" \"" .. make_dir .. "cd " .. project_dir .. "; nvim " .. nvim_open_mode .."; $SHELL\""
end

local function linuxSystemCmd(use_tabs, open_session, project_dir)
	local tab = ""
	if use_tabs then 
		tab = "--tab " 
	end

	local make_dir = makeDir(project_dir)
	local nvim_open_mode = nvimOpenMode(open_session, project_dir)

	return	"gnome-terminal " .. tab .. "-- bash -c '".. make_dir .. "cd " .. project_dir .. "; nvim " .. nvim_open_mode .. "; $SHELL'"
end

local function selectFolder(prompt_bufnr, map)
	local function newTerminal(use_tabs, open_session)
		local content = require('telescope.actions.state').get_selected_entry(prompt_bufnr)
		local project_dir = content.text

		local system_cmd
		if vim.fn.getenv("TMUX") == vim.NIL then
			system_cmd = linuxSystemCmd(use_tabs, open_session, project_dir)
			print(system_cmd)
		else
			system_cmd = tmuxSystemCmd(use_tabs, open_session, project_dir)
			print(system_cmd)
		end

		-- vim.fn.system(system_cmd)
	end


	map('n', '<C-s>', function()
		newTerminal(false, true)
	end)

	map('i', '<C-s>', function()
		newTerminal(true, true)
	end)

	map('i', '<C-t>', function()
		newTerminal(true, false)
	end)

	map('n', '<C-t>', function()
		newTerminal(false, false)
	end)
end


M.quickProjects = function()
	require("telescope.builtin").live_grep({
		prompt_title =  "quick projects >",
		cwd = "~/.vim/quick_projects/",

		attach_mappings = function(prompt_bufnr, map)
			selectFolder(prompt_bufnr, map)
			return true
		end
	})
end

return M
