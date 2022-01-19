require("telescope").load_extension("neoclip")
require('neoclip').setup()
-- vim.keymap.set("n", "<leader>cs", require('telescope').extensions.neoclip.star) -- doesn't seem to work
vim.keymap.set("n", "<leader>cc", require('telescope').extensions.neoclip.default)
