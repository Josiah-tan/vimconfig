-- for plover-live-view-nvim
require("plover_viewer").setup({
	builtin = {
		cwd = {"~/.config/plover/", "/mnt/c/Users/josia/AppData/Local/plover/plover/"},
		file_name = "clippy.txt"
	},
	disable_default_mappings = true,
})


vim.keymap.set('n', '<leader>pc', function () RELOAD("plover_viewer.builtin").view() end)
vim.keymap.set('n', '<leader>pv', function () RELOAD("plover_viewer.builtin").splitToggle() end)
vim.keymap.set('n', '<leader>pp', function () RELOAD("plover_viewer.builtin").view({file_name = "tapey_tape.txt"}) end)
