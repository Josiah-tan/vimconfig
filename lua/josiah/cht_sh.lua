M = {}
M.temp = {}

M.setup = function(opts)
	opts = opts or {}
	local defaults = {terminal = 3,
	language_list = {
		["python"] = {},
		["python3"] = {},
		["c"] = {},
		["cpp"] = {},
		["makefile"] = {},
		["git"] = {"set url", "master main", "all branch"},
		["lua"] = {"table concatenate"}},
	search_query = {"split", "read file"}}
	M.opts = vim.tbl_deep_extend("force", defaults, opts)
end

local function runCurl()
	local command = string.format("curl cht.sh/%s/%s\n", M.selection, M.query)
	require("harpoon.term").sendCommand(M.temp.opts.terminal, command)
	require("harpoon.term").gotoTerminal(M.temp.opts.terminal)
end

local function getSelection(prompt_bufnr)
	local content = require("telescope.actions.state").get_selected_entry(
	prompt_bufnr
	)
	local current_line = require("telescope.actions.state").get_current_line()
	require("telescope.actions").close(prompt_bufnr)
	if content then
		content = content.value
	else
		content = current_line
	end
	-- require("refactoring").refactor(content.value)
	return content
end

local function selectQuery(prompt_bufnr)
	M.query = getSelection(prompt_bufnr)
	M.query = string.gsub(M.query, " ", "+")
	runCurl()
end

local function tableConcat(t1,t2)
	if t2 then
		for i=1,#t2 do
			t1[#t1+1] = t2[i]  --corrected bug. if t1[#t1+i] is used, indices will be skipped
		end
	end
	return t1
end


-- schedule_wrap fixes bug where telescope doesn't load properly for the second phase
M.searchQuery = vim.schedule_wrap(function(opts)
	require("telescope.pickers").new(opts, {
		prompt_title = "choose query > ",
		finder = require("telescope.finders").new_table({
			-- results = opts.search_query --[[ require("refactoring").get_refactors() ]],
			results = tableConcat(opts.search_query, opts.language_list[M.selection])
		}),
		sorter = require("telescope.config").values.generic_sorter(opts),
		attach_mappings = function(_, map)
			map("i", "<CR>", selectQuery)
			map("n", "<CR>", selectQuery)
			return true
		end
	}):find()
end)

local function selectLangAndSearch(prompt_bufnr)
	M.selection = getSelection(prompt_bufnr)
	M.searchQuery(M.temp.opts)
end


M.cheatSh = function(opts)
	opts = opts or {}
	M.temp.opts = vim.tbl_deep_extend("force", M.opts, opts)
	-- M.temp.opts = opts
	require("telescope.pickers").new(opts, {
		prompt_title = "choose lang > ",
		finder = require("telescope.finders").new_table({
			results = vim.tbl_keys(M.temp.opts.language_list) --[[ require("refactoring").get_refactors() ]],
			-- results = M.temp.opts.language_list --[[ require("refactoring").get_refactors() ]],
		}),
		sorter = require("telescope.config").values.generic_sorter(opts),
		attach_mappings = function(_, map)
			map("i", "<CR>", selectLangAndSearch)
			map("n", "<CR>", selectLangAndSearch)
			return true
		end
	}):find()
end

M.setup()
vim.api.nvim_set_keymap("n", "<Leader>ch", ':lua RELOAD("josiah.cht_sh").cheatSh()<CR>', {noremap = true, silent = true, expr = false})
-- vim.api.nvim_set_keymap("n", "<Leader>sq", <Esc><Cmd>lua RELOAD('josiah.cht_sh').searchQuery(opts)<CR>, {noremap = true, silent = true, expr = false})

return M

-- vim.tbl_keys(refactors.refactor_names)
-- M.refactor_names = {
--     ["Inline Variable"] = "inline_var",
--     ["Extract Variable"] = "extract_var",
--     ["Extract Function"] = "extract",
--     ["Extract Function To File"] = "extract_to_file",
-- }
--
-- M.refactor_names = {
--     ["Inline Variable"] = "inline_var",
--     ["Extract Variable"] = "extract_var",
--     ["Extract Function"] = "extract",
--     ["Extract Function To File"] = "extract_to_file",
-- }
-- P("a: ", a)
-- if opts.cwd then
-- opts.cwd = vim.fn.expand(opts.cwd)
-- end
--
-- opts.entry_maker = opts.entry_maker or make_entry.gen_from_file(opts)
--
-- pickers.new(opts, {
-- prompt_title = "Find Files",
-- finder = finders.new_oneshot_job(find_command, opts),
-- previewer = conf.file_previewer(opts),
-- sorter = conf.file_sorter(opts),
-- }):find()
--
-- local a = vim.tbl_keys({
--     ["Inline Variable"] = "inline_var",
--     ["Extract Variable"] = "extract_var",
--     ["Extract Function"] = "extract",
--     ["Extract Function To File"] = "extract_to_file",
-- })
--

