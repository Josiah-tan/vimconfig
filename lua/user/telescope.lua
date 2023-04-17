local actions = require("telescope.actions")

require("telescope").setup {
  pickers = {
   --  git_files = {
   --    mappings = {
   --      i = {
   --        ["<C-o>"] = function(prompt_bufnr, map)
			-- local content = require('telescope.actions.state').get_selected_entry()
			-- require('telescope.actions').close(prompt_bufnr)
			-- P("content:", content)
			-- P("content cwd:", content["cwd"])
			-- local text = "!xdg-open "..content["cwd"].."/"..content[1].." &"
			-- vim.cmd(text)
			-- return true
		 --  end
   --      },
   --    },
   --  }, -- yeah I don't know why this doesn't work on windows, the full path gives an error when xdg-open for some reason
    find_files = {
      mappings = {
        i = {
          ["<C-o>"] = function(prompt_bufnr, map)
			local content = require('telescope.actions.state').get_selected_entry()
			require('telescope.actions').close(prompt_bufnr)
			local text = "!xdg-open "..content[1].." &"
			vim.cmd(text)
			return true
		  end
        },
      },
    },
  },
}

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
		extensions = {
			fzf = {
				fuzzy = true, -- false => only exact matching
				override_generic_sorter = true, -- override generic sorter 
				override_file_sorter = true, -- ovverride the file sorter
				case_mode = "smart_case" -- "ignore_case" or "respect_case", default = "smart_case"
			}
		}
		-- fzy_native = {
		-- 	override_generic_sorter = false,
		-- 	override_file_sorter = true,
		-- 	["ui-select"] = {
		-- 		require("telescope.themes").get_dropdown{
		-- 		}
		-- 	}
		-- }
	}
}

-- require('telescope').load_extension('fzy_native')



require('telescope').load_extension('fzf')

-- require('telescope').setup {
-- 	extensions = {
-- 		["ui-select"] = {
-- 			require("telescope.themes").get_dropdown{
-- 			}
-- 		}
-- 	}
-- }

require("telescope").load_extension("ui-select")

local M = {}

M.stringGrepDotFiles = function()
	require("telescope.builtin").grep_string({
		cwd = "~/.vim/",
	})
end


M.grepDotFiles = function()
	require("telescope.builtin").grep_string({
		search = vim.fn.input("vimrc grep for > "),
		cwd = "~/.vim/",
	})
end


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
	if vim.fn.filereadable(vim.fn.expand(sess)) == 1 and open_session then
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

		vim.fn.system(system_cmd)
		require('telescope.actions').close(prompt_bufnr)
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


-- TODO:
-- make into a plugin, call it quick-projects-nvim
-- path shortener: some paths could be very long
-- make it so that you don't start a new window and session when the window is already there
-- make it so that you can group windows within the session, as denoted by file-directory paths within the session name
-- 		instead of:
-- 			project.txt
-- 				~/Desktop/..../amme2300
-- 				~/Desktop/..../elec1103
-- 				~/Desktop/..../resumes
-- 		do this:
-- 			uni.txt
-- 				~/Desktop/..../amme2300
-- 				~/Desktop/..../elec1103
-- 			work.txt
-- 				~/Desktop/..../resumes

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

M.findPlugins = function()
	require("telescope.builtin").find_files({
		prompt_title = "find plugins >",
		cwd = "~/.local/share/nvim/plugged/",
	})
end

M.stringGrepPlugins = function()
	require("telescope.builtin").grep_string({
		cwd = "~/.local/share/nvim/plugged/",
	})
end

M.grepPlugins = function()
	require("telescope.builtin").grep_string({
		search = vim.fn.input("plugin grep for > "),
		cwd = "~/.local/share/nvim/plugged/",
	})
end

M.findFilesCurrentBufferDir = function()
	require("telescope.builtin").find_files({
		search_dirs = {"%:h"},
		path_display = { "shorten" },
	})
end



M.findPloverFiles = function ()
	require("telescope.builtin").find_files({
		prompt_title = "find plover >",
		cwd = "~/plover/"
	})
end

M.stringGrepPloverFiles = function ()
	require("telescope.builtin").grep_string({
		cwd = "~/plover/"
	})
end

M.grepPloverFiles = function ()
	require("telescope.builtin").grep_string({
		search = vim.fn.input("grep plover > "),
		cwd = "~/plover/"
	})
end

require('telescope').load_extension('gh')

M.findOrgFiles = function ()
	require("telescope.builtin").find_files({
		prompt_title = "find org >",
		cwd = "~/org/"
	})
end

M.stringGrepOrgFiles = function ()
	require("telescope.builtin").grep_string({
		cwd = "~/org/"
	})
end

M.grepOrgFiles = function ()
	require("telescope.builtin").grep_string({
		search = vim.fn.input("grep org > "),
		cwd = "~/org/"
	})
end

M.findCaptionFiles = function ()
	require("telescope.builtin").find_files({
		prompt_title = "find org/cap >",
		cwd = "~/org/cap/"
	})
end

M.stringGrepCaptionFiles = function ()
	require("telescope.builtin").grep_string({
		cwd = "~/org/cap/"
	})
end

M.grepCaptionFiles = function ()
	require("telescope.builtin").grep_string({
		search = vim.fn.input("grep org/cap > "),
		cwd = "~/org/cap/"
	})
end

M.stringGrepStanleyFiles = function ()
	require("telescope.builtin").grep_string({
		cwd = "~/Stanley/"
	})
end

M.grepStanleyFiles = function ()
	require("telescope.builtin").grep_string({
		search = vim.fn.input("grep Stanley > "),
		cwd = "~/Stanley/"
	})
end

M.findStanleyFiles = function ()
	require("telescope.builtin").find_files({
		prompt_title = "find Stanley >",
		cwd = "~/Stanley/"
	})
end

local function getPloverConfigDirectory()
	local cwds = {"~/.config/plover/", "/mnt/c/Users/josia/AppData/Local/plover/plover/"}
	for _, cwd in ipairs(cwds) do
		if vim.fn.isdirectory(vim.fn.expand(cwd)) == 1 then
			return cwd
		end
	end
	P("problem! plover config directory does not exist")
end

local function getLightFieldDirectory()
	local cwds = {"~/LFToolbox/"}
	for _, cwd in ipairs(cwds) do
		if vim.fn.isdirectory(vim.fn.expand(cwd)) == 1 then
			return cwd
		end
	end
	P("problem! light field directory does not exist")
end

M.findPloverConfigFiles = function ()
	require("telescope.builtin").find_files({
		prompt_title = "find plover config >",
		cwd = getPloverConfigDirectory()
	})
end

M.stringGrepPloverConfigFiles = function ()
	require("telescope.builtin").grep_string({
		cwd = getPloverConfigDirectory()
	})
end

M.grepPloverConfigFiles = function ()
	require("telescope.builtin").grep_string({
		search = vim.fn.input("grep plover config > "),
		cwd = getPloverConfigDirectory()
	})
end

M.findLightFieldFiles = function ()
	require("telescope.builtin").find_files({
		prompt_title = "find light field >",
		cwd = getLightFieldDirectory()
	})
end

M.stringGrepLightFieldFiles = function ()
	require("telescope.builtin").grep_string({
		cwd = getLightFieldDirectory()
	})
end

M.grepLightFieldFiles = function ()
	require("telescope.builtin").grep_string({
		search = vim.fn.input("grep light field > "),
		cwd = getLightFieldDirectory()
	})
end

return M
