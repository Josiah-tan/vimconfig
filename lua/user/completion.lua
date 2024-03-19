
-- Set completeopt to have a better completion experience
-- set completeopt=menuone,noinsert,noselect
-- Avoid showing message extra message when using completion
-- set shortmess+=c
local lsp_zero = require("lsp-zero")


vim.opt.completeopt = {"menu", "menuone", "noselect"}
vim.opt.shortmess:append "c"

-- bruh I don't know what this is for
-- local lspkind = require "lspkind"
-- lspkind.init()

local cmp = require "cmp"
local cmp_select = {behavior = cmp.SelectBehavior.Select}

vim.api.nvim_create_autocmd("FileType", {
	pattern = "org",
	callback = function()
		if vim.fn.expand("%:p"):match(".*/org/cap/.*") then -- disable in my cap files
			require("cmp").setup.buffer{enabled = false}
		end
	end,
})

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.close(),
		["<C-y>"] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		},
		["<CR>"] = nil,
		["<c-space>"] = cmp.mapping.complete(),
		["<C-p>"] = cmp.mapping.select_prev_item {cmp_select},
		["<C-n>"] = cmp.mapping.select_next_item {cmp_select}
	}),
	sources = {  -- sources to use to provide completions, sources enabled globally, automatic ranking with order
		{name = 'orgmode'},
		{name = "gh_issues"},
		{name = "nvim_lua"}, -- note that this already enables itself only in lua
		{name = "nvim_lsp"},
		{name = "path"},
		{name = "luasnip"},
		{name = "nvim_lsp_signature_help"},
		{name = "buffer", keyword_length = 4} -- won't suggest anything from the buffer until after you type 5 characters
	},
	snippet = {
		-- include snippets
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	formatting = lsp_zero.cmp_format({details = false}),
	experimental = {
		native_menu = false,  -- trying the new completion menu
		ghost_text = true, -- virtual text not inserted into the buffer yet
	},

})

-- autocompletion for command line paths, and commands
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline', keyword_length = 4 }
	})
})

-- when performing a search do some autocompletion
cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
'confirm_done',
cmp_autopairs.on_confirm_done()
)
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- require('lspconfig')['clangd'].setup {
	-- 	capabilities = capabilities
	-- }
	-- file type only configuration example
	-- vim.cmd [[
	-- 	augroup NvimLua
	-- 		au!
	-- 		autocmd FileType lua lua require'cmp'.setup.buffer{ sources = {name = 'nvim_lua'}}
	-- 	augroup END
	-- ]]

	-- its also possible to turn comp off for a buffer, (note that in telescope you don't actually need to do it)
	-- autocmd FileType TelescopePrompt lua require('cmp').setup.buffer {enabled = false}


	-- customizing the appearance
	-- require('colorbuddy').colorscheme('gruvbuddy') -- this for some reason changes my colorscheme and I don't like that
	-- local Group = require("colorbuddy.group").Group
	-- local g = require("colorbuddy.group").groups
	-- local s = require("colorbuddy.style").styles
	-- Group.new("CmpItemAbbr", g.Comment)
	-- Group.new("CmpItemAbbrDeprecated", g.Error)
	-- Group.new("CmpItemAbbrMatchFuzzy", g.CmpItemAbbr.fg:dark(), nil, s.italic)
	-- Group.new("CmpItemKind", g.Special)
	-- Group.new("CmpItemMenu", g.NonText)

