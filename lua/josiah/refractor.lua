-- local refactor = require("refactoring")
-- refactor.setup()
--
-- telescope refactoring helper
-- local function refactorHelper(prompt_bufnr)
--     local content = require("telescope.actions.state").get_selected_entry(
--         prompt_bufnr
--     )
--     require("telescope.actions").close(prompt_bufnr)
--     require("refactoring").refactor(content.value)
-- end
-- NOTE: M is a global object
-- for the sake of simplicity in this example
-- you can extract this function and the helper above
-- and then require the file and call the extracted function
-- in the mappings below
-- M = {}
-- M.refactors = function()
--     require("telescope.pickers").new({}, {
--         prompt_title = "refactors",
--         finder = require("telescope.finders").new_table({
--             results = require("refactoring").get_refactors(),
--         }),
--         sorter = require("telescope.config").values.generic_sorter({}),
--         attach_mappings = function(_, map)
--             map("i", "<CR>", refactorHelper)
--             map("n", "<CR>", refactorHelper)
--             return true
--         end
--     }):find()
-- end

-- vim.api.nvim_set_keymap("v", "<Leader>re", [[ <Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false})
-- vim.api.nvim_set_keymap("v", "<Leader>rf", [[ <Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], {noremap = true, silent = true, expr = false})
-- vim.api.nvim_set_keymap("v", "<Leader>rt", [[ <Cmd>lua M.refactors()<CR>]], {noremap = true, silent = true, expr = false})
-- -- local refactor = require("refactoring")
-- refactor.setup()

-- vim.api.nvim_set_keymap("v", "<Leader>re", [[ <Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false})

-- require('refactoring').setup({})
require('refactoring').setup({
    -- prompt for return type
    prompt_func_return_type = {
        go = true,
		cpp = true,
		c = true,
    },
    -- prompt for function parameters
    prompt_func_param_type = {
        go = true,
        cpp = true,
        c = true,
    },
})

vim.api.nvim_set_keymap("v", "<Leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<Leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<Leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<Leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})

require("telescope").load_extension("refactoring")

-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
	"v",
	"<leader>rr",
	"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
	{ noremap = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>rp",
	":lua require('refactoring').debug.printf({below = true})<CR>",
	{ noremap = true }
)

vim.api.nvim_set_keymap("v", "<leader>rp", ":lua require('refactoring').debug.print_var({})<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>ru", ":lua require('refactoring').debug.cleanup({})<CR>", { noremap = true })
