-- for plover-live-view-nvim

require("plover_viewer").setup({
	builtin = {
		viewer = {
			terminal = {
				command_args = {"-f", "---disable-inotify"}
			}
		},
		cwd = {"~/.config/plover/", "/mnt/c/Users/josia/AppData/Local/plover/plover/"},
		file_name = "clippy.txt"
	},
	disable_default_mappings = true,
})


vim.keymap.set('n', '<leader>pp', function () RELOAD("plover_viewer.builtin").view() end)
vim.keymap.set('n', '<leader>ps', function () RELOAD("plover_viewer.builtin").splitToggle({
	viewer = {
		terminal = {
			number = 6
		}
	}
}) end)
vim.keymap.set('n', '<leader>pv', function () RELOAD("plover_viewer.builtin").splitToggle({
	file_name = "tapey_tape.txt",
	viewer = {
		terminal = {
			number = 7
		}
	},
	split = {
		choose = "vertical"
	}
}) end)
