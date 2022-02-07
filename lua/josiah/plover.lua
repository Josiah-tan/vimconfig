require("autoread").setup({
	builtin = {
		job = {
			command = "sh",
			args = {'-c', 'tail ---disable-inotify -n0 -F -- %s'},
		},
		-- cwd = {"~/.config/plover/", "/mnt/c/Users/josia/AppData/Local/plover/plover/"},
		-- file_name = "clippy_2.org"
		cwd = nil,
		file_name = nil
	},
	disable_default_mappings = true,
	verbose = true,
})

-- vim.keymap.set("n", "<leader>js", function() RELOAD("autoread.builtin").autoReadStart({file_name = "clippy.txt"}) end)
vim.keymap.set("n", "<leader>js", function() RELOAD("autoread.builtin").autoReadStart() end)
vim.keymap.set("n", "<leader>je", function() RELOAD("autoread.builtin").autoReadStop() end)

-- for plover-live-view-nvim
require("plover_viewer").setup({
	builtin = {
		viewer = {
			terminal = {
				args = {"-f", "---disable-inotify"}
			}
		},
		cwd = {"~/.config/plover/", "/mnt/c/Users/josia/AppData/Local/plover/plover/"},
		file_name = "clippy.txt",
		-- hooks = {
		-- 	bufWinEnter = function () require("autoread.builtin").autoReadStart() end,
		-- 	bufWinLeave = function () require("autoread.builtin").autoReadStop() end -- not work, tries end job wrong buffer
		-- }
	},
	disable_default_mappings = true,
})


vim.keymap.set('n', '<leader>pp', function () RELOAD("plover_viewer.builtin").view({viewer = {choose = "buf"}}) end)
vim.keymap.set('n', '<leader>ps', function () RELOAD("plover_viewer.builtin").splitToggle({
	file_name = "clippy_2.org",
	-- file_name = "clippy.txt",
	viewer = {
		choose = "buf",
		terminal = {
			number = 6
		}
	},
	hooks = {
		bufWinEnter = function () require("autoread.builtin").autoReadStart({
			cwd = {"~/.config/plover/", "/mnt/c/Users/josia/AppData/Local/plover/plover/"},
			file_name = "clippy_2.org"
		}) end,
		bufWinLeave = function () require("autoread.builtin").autoReadStop({
			cwd = {"~/.config/plover/", "/mnt/c/Users/josia/AppData/Local/plover/plover/"},
			file_name = "clippy_2.org"
		}) end
	}
}) end)


vim.keymap.set('n', '<leader>pv', function () RELOAD("plover_viewer.builtin").splitToggle({
	file_name = "clippy.txt",
	viewer = {
		choose = "terminal",
		terminal = {
			number = 7
		}
	},
	split = {
		choose = "vertical"
	},
	hooks = {
		bufWinEnter = function () require("autoread.builtin").autoReadStart({
			cwd = {"~/.config/plover/", "/mnt/c/Users/josia/AppData/Local/plover/plover/"},
			file_name = "clippy.txt"
		}) end,
		bufWinLeave = function () require("autoread.builtin").autoReadStop({
			cwd = {"~/.config/plover/", "/mnt/c/Users/josia/AppData/Local/plover/plover/"},
			file_name = "clippy.txt"
		}) end
	}
}) end)


-- for plover debuggin
local location = "~/Downloads/plover-4.0.0.dev10+120.g4394ef1-x86_64.AppImage"
local exec = location .. " --log-level debug\n"
local stop_exec = location ..  " -s plover_send_command quit\n"
-- starts plover
vim.keymap.set("n", '<leader>pr', function () require("harpoon.term").sendCommand(2, exec) end)
-- kills plover
vim.keymap.set("n", '<leader>pc', function () require("harpoon.term").sendCommand(3, stop_exec) end)


local getConfigDirectory = function ()
	local config_directory = vim.fn.expand('/mnt/c/Users/josia/AppData/Local/plover/plover/')
	if (vim.fn.isdirectory(config_directory) == 0) then
		config_directory = "~/.dotfiles/plover/.config/plover/"
	end
	return config_directory
end

local editDictionary = function (dictionary)
	local config_directory = getConfigDirectory()
	dictionary = config_directory .. dictionary
	if vim.fn.filereadable(dictionary) then
		vim.cmd("e "..dictionary)
	else
		print("dictionary not readable: " .. dictionary)
	end
end

vim.keymap.set("n", '<leader>uv', function () editDictionary("vim.json") end)
vim.keymap.set("n", '<leader>uu', function () editDictionary("programming.json") end)


-- great idea but not going to work because of the fact that I might not have
-- vim.cmd[[
-- augroup PLOVERAuto
-- 	autocmd!
-- 	autocmd VimLeave * lua require("harpoon.term").sendCommand(2, stop_exec)
-- augroup END
-- ]]


-- for live viewing doesn't seem to work very well... (copied from help watch-file)

-- local w = vim.loop.new_fs_event()
-- local function on_change(err, fname, status)
-- 	-- Do work...
-- 	vim.api.nvim_command('checktime')
-- 	-- Debounce: stop/start.
-- 	w:stop()
-- 	watch_file(fname)
-- end
-- function watch_file(fname)
-- 	local fullpath = vim.api.nvim_call_function(
-- 		'fnamemodify', {fname, ':p'})
-- 	w:start(fullpath, {}, vim.schedule_wrap(function(...)
-- 		on_change(...) end))
-- end
-- vim.api.nvim_command(
-- 	"command! -nargs=1 Watch call luaeval('watch_file(_A)', expand('<args>'))")


-- vim.cmd[[checktime]]
-- vim.api.nvim_win_set_cursor(0, {vim.fn.line('$'), 0})

-- local window = 1000
-- local delay = 500
-- local autoEOF = true

-- local timer_on = false
-- local timer_id = nil

-- local checkUpdate = function ()
-- 	vim.cmd[[silent! checktime]]
-- 	if autoEOF then
-- 		-- vim.api.nvim_win_set_cursor(window, {vim.api.nvim_buf_line_count(vim.api.nvim_win_get_buf(window)), 0})
-- 	end
-- end

-- ToggleRefresh = function ()
-- 	if timer_on then
-- 		vim.fn.timer_stop(timer_id)
-- 		timer_on = false
-- 	else
-- 		timer_id = vim.fn.timer_start(delay, checkUpdate, {['repeat'] = -1})
-- 		timer_on = true
-- 	end
-- end
--
-- vim.keymap.set("n", '<leader>ct', ToggleRefresh)


-- function! CheckUpdate(t)
-- 	"updates the file
--     silent! checktime
-- 	"moves cursor down to the bottom of the file
-- 	if g:ploverAutoEOF
-- 		:call cursor(line('$'),1)
-- 	endif
-- 	if g:ploverAutoPosition == "centre"
-- 		norm! zz
-- 	elseif g:ploverAutoPosition == "bottom"
-- 		norm! zb
-- 	elseif g:ploverAutoPosition == "top"
-- 		norm! zt
-- 	endif
-- endfunction
--
-- function! PloverCyclicRefreshBufferOn()
-- 	" every (g:ploverUpdateTimer) ms, call checkUpdate infinitely
-- 	let b:clippyTimer = timer_start(g:ploverUpdateTimer, "CheckUpdate", {'repeat': -1})
-- 	let b:clippyOff = 0
-- endfunction
--
-- function! PloverCyclicRefreshBufferOff()
-- 	" stop calling checkupdate when switching buffers
-- 	if exists("b:clippyTimer")
-- 		call timer_stop(b:clippyTimer)
-- 	endif
-- 	let b:clippyOff = 1
-- endfunction
