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

M.search_dotfiles = function()
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

M.git_branches = function()
	require("telescope.builtin").git_branches({
		attach_mappings = function(prompt_bufnr, map)
			map('i', '<c-d>', actions.git_delete_branch)
			map('n', '<c-d>', actions.git_delete_branch)
			return true
		end
	})
end

M.live_grep = function()
	require("telescope.builtin").grep_string({
		 search = vim.fn.input("Grep For > ")
	})
end


local function select_folder(prompt_bufnr, map)
	local function new_terminal(use_tabs)
		local content =
        require('telescope.actions.state').get_selected_entry(prompt_bufnr)
		local project_dir = content.text

		if use_tabs then 
			tab = "--tab" 
		else
			tab = ""
		end

		if vim.fn.isdirectory(content) then
			make_dir = ""
		else
			make_dir = "mkdir -p " .. content .. ";"
		end

		local sess = content .. "Session.vim"


		if vim.fn.filereadable(sess) then
			nvim_open = "-s " .. sess
		else
			nvim_open = "."
		end


		vim.fn.system(
			-- "gnome-terminal --tab -- bash -c 'echo 'h'; $SHELL'"
			"gnome-terminal " .. tab .. " -- bash -c '".. make_dir .. " cd " .. project_dir .. "; nvim " .. nvim_open .."; $SHELL'"
		)
		-- P(content.text)
		--
	end


	map('i', '<C-t>', function()
		new_terminal(false)
	end)
end


M.quick_projects = function()
	require("telescope.builtin").live_grep({
		prompt_title =  "quick projects>",
		cwd = "~/.vim/quick_projects/",

		attach_mappings = function(prompt_bufnr, map)
			select_folder(prompt_bufnr, map)
			return true
		end
	})
end

return M
