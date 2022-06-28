M = {}
-- Set completeopt to have a better completion experience
-- set completeopt=menuone,noinsert,noselect
-- Avoid showing message extra message when using completion
-- set shortmess+=c

vim.opt.completeopt = {"menu", "menuone", "noselect"}
vim.opt.shortmess:append "c"

local lspkind = require "lspkind"
lspkind.init()

local cmp = require "cmp"

M.setup = function()
	cmp.setup {
		mapping = {
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-e>"] = cmp.mapping.close(),
			["<C-y>"] = cmp.mapping.confirm {
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			},
			["<c-space>"] = cmp.mapping.complete(),
		},
		sources = {  -- sources to use to provide completions, sources enabled globally, automatic ranking with order
		{name = "gh_issues"},
		{name = "nvim_lua"}, -- note that this already enables itself only in lua
		{name = "nvim_lsp"},
		{name = "path"},
		{name = "luasnip"},
		{name = "buffer", keyword_length = 5}, -- won't suggest anything from the buffer until after you type 5 characters
	},
	snippet = {
		-- include snippets
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	formatting = {
		format = lspkind.cmp_format {
			with_text = true,
			menu = {
				buffer = "[buf]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[api]",
				path = "[path]",
				luasnip = "[snip]",
				gh_issues = "[issues]",
			}
		}
	},

	experimental = {
		native_menu = false,  -- trying the new completion menu
		ghost_text = true, -- virtual text not inserted into the buffer yet
	},

}

-- autocompletion for command line paths, and commands
cmp.setup.cmdline(':', {
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline', keyword_length = 4 }
	})
})

-- when performing a search do some autocompletion
cmp.setup.cmdline('/', {
	sources = {
		{ name = 'buffer' }
	}
})
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
end
return M
