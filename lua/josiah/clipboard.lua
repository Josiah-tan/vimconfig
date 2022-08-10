require("telescope").load_extension("neoclip")
require('neoclip').setup()
-- vim.keymap.set("n", "<leader>cs", require('telescope').extensions.neoclip.star) -- doesn't seem to work
vim.keymap.set("n", "<leader>cc", require('telescope').extensions.neoclip.default)
vim.keymap.set("n", "<leader>cf", function ()
	if vim.fn.has("Linux") == 1 then
		vim.fn.system("cat "..vim.fn.expand('%:p').." | xclip -sel clip")
	else
		vim.fn.system("cat "..vim.fn.expand('%:p').." | clip.exe")
	end
end)
