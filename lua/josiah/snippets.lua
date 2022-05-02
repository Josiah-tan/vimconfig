local ls = require("luasnip")
local types = require("luasnip.util.types")

ls.config.set_config {
	--  when you make mistakes and want to go back
	history = true,

	-- live updates as you type
	updateevents = "TextChanged,TextChangedI",

	-- not sure what this is for exactly?
	enable_autosnippets = true,

	-- vid 3 (apparently op)
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = {{"<-", "Error"}},
			}
		}
	}
}


-- expansion key, jumps to next item within the snippet
vim.keymap.set({"i", "s"}, "<M-k>", function ()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, {silent = true})

-- jump backwards, to the previous item within the snippet
-- (note that <c-j> by default does a newline, kinda useless lol)
vim.keymap.set({"i", "s"}, "<M-j>", function ()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, {silent = true})

-- selection within a list of options (choice nodes in vid 2)
-- that errors.wrap and errors thing that he showed in the video
vim.keymap.set("i", "<M-l>", function ()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

local s = ls.s
local fmt = require("luasnip.extras.fmt").fmt
local i = ls.insert_node
local rep = require("luasnip.extras").rep

-- vs**** style snippets... lol (ls.parser.parse_snippet)
ls.snippets = {
	all = {
		-- any filetype
		ls.parser.parse_snippet("expand", "my first snippet ever!"),
	},
	lua = {
		-- filetype lua
		ls.parser.parse_snippet("local function", "-- defined in $TM_FILENAME\nlocal $1 = function($2)\n	$0\nend"),
			ls.parser.parse_snippet("method function", "$1.$2 = function($3)\n	$0\nend"),
				s('require', fmt("local {} = require('{}')", {i(1, "default"), rep(1)})),
			},
			org = {
				-- filetype org
				s('figure', fmt("#+BEGIN_SRC latex\n\\begin{{figure}}[H]\\centering\\includegraphics[width=0.7\\textwidth]{{TEK000{}.png}}\\caption{{graph}}\\label{{fig:{}}}\\end{{figure}}\n#+END_SRC", {i(1, "number"), rep(1)})),
			},
			tex = {
				s('fig', fmt("\\begin{{figure}}[H]\\centering\\includegraphics[width=0.7\\textwidth]{{{}.png}}\\caption{{graph}}\\label{{fig:{}}}\\end{{figure}}\n#+END_SRC", {i(1, "image"), rep(1)})),
				-- ls.parser.parse_snippet("expand", "testing if this works in org"),
			}
		}
