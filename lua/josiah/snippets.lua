local ls = RELOAD("luasnip")
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
				virt_text = {{"<- current choice", "NonTest"}},
			}
		}
	}
}

vim.keymap.set("i", "<M-s>", require "luasnip.extras.select_choice")
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
local c = ls.choice_node
local t = ls.text_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.sn
local isn = ls.indent_snippet_node

local same = function(index)
	return f(function(arg)
		 --TODO
		 -- print(vim.inspect(arg))
		 return arg[1]
	end, {index})
end


-- vs**** style snippets... lol (ls.parser.parse_snippet)
ls.add_snippets("all", {
	-- any filetype
	ls.parser.parse_snippet("expand", "my first snippet ever!"),
	s("todo", {
		c(1, {
			t "TODO(Josiah): ",
			t "FIXME(Josiah): ",
			t "TODONT(Josiah): ",
			t "TODO(anybody please help me): ",
		})
	}
	),
	s("time", { -- trying to understand the function node
		f(function() return os.date "%D - %H:%M" end)
	}),
	s("same test",	fmt([[example: {}, function: {}]], {i(1), same(1)}))
})

local get_test_result_rust = function(position)
	return d(position, function()
		local nodes = {}
		table.insert(nodes, t " ")
		local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
		for _, line in ipairs(lines) do
			if line:match("anyhow::Result") then
				table.insert(nodes, t " -> Result<()>")
				break
			end
		end
		return sn(nil, c(1, nodes))
	end, {})
end


ls.add_snippets("rust", {
	s(
	"module test", -- trying to understand the choice nodes
	fmt(
	[[
	#[cfg(test)]
	mod test {{
		{}
		
			{}
	}}
	]],
	{
		c(1, {t "		use super::*;", t""}),
		i(0), -- put my cursor here once I am all done
	})),
	s("test",
	fmt(
	[[
	#[test]
	fn {}(){}{{
		 {}
	}}
	]],
	{
		i(1, "testname"),
		get_test_result_rust(2), -- 2 is the place where it places the result
		i(0),
	}
	)
	)
})


ls.add_snippets("org", {
	-- filetype org
	s('figure', fmt("#+BEGIN_SRC latex\n\\begin{{figure}}[H]\\centering\\includegraphics[width=0.7\\textwidth]{{TEK000{}.png}}\\caption{{graph}}\\label{{fig:{}}}\\end{{figure}}\n#+END_SRC", {i(1, "number"), rep(1)})),
})

ls.add_snippets("tex", {
	s('fig', fmt("\\begin{{figure}}[H]\\centering\\includegraphics[width=0.7\\textwidth]{{photos/{}.png}}\\caption{{graph}}\\label{{fig:{}}}\\end{{figure}}", {i(1, "image"), rep(1)})),
	-- ls.parser.parse_snippet("expand", "testing if this works in org"),
	s('matrix', fmt("\\begin{{bmatrix}}\n\t{}\n\\end{{bmatrix}}", {i(1, "1 & 2 & 3 \\\\")})),
	s('align', fmt("\\begin{{align*}}\n\t{}\n\\end{{align*}}", {i(1, "a + b &= c \\\\")})),
	s('itemize', fmt("\\begin{{itemize}}\n\t\\item {}\n\\end{{itemize}}", {i(1, "item here")}))
})

local splitVariables = function(s)
	sep = ","
	local t = {}
	for str in string.gmatch(s, "([^"..sep.."]+)") do
		str = vim.trim(str)
		local last = str:match('([A-Za-z\\_]*)$') --> ' is in the middle.'
		local start = vim.trim(str:sub(1, str:len() - last:len()))
		table.insert(t, {start, last})
	end
	return t
end

ls.add_snippets("cpp", {
	s("hello", t "hello world what on earth is going on these days"),
	s("class",
	fmt(
	[[
	class {}{{
		private:
		{}
		public:
			{}({}): {}{{
				{}
			}}
	}};
	]],
	{
		i(1, "ClassName"),
		d(3,
		function (arguments)
			local variables = splitVariables(arguments[1][1])
			local results = {}
			for _, value in ipairs(variables) do
				local variable_type = value[1]
				local variable_value = value[2]
				table.insert(results, "\t" .. variable_type .. " " .. variable_value .. ";")
			end
			return isn(1, t(results), "$PARENT_INDENT\t")
		end, 2),
		same(1),
		i(2, "arguments"),
		d(4,
		function (arguments)
			local variables = splitVariables(arguments[1][1])
			local results = {}
			for _, value in ipairs(variables) do
				local variable_value = value[2]
				table.insert(results, variable_value .. "(" .. variable_value .. ")")
			end
			return sn(nil, t(table.concat(results, ", ")))
		end, 2),
		i(0),
	}
	))
})

		
-- s = ' vector<int>hello , int what '

-- print(s:match('^(.*)777')) --> 'The number '
-- print(s:match('([A-Za-z\\_]*)$')) --> ' is in the middle.'

-- P(s:match('([A-Za-z\\_]*)$'))
-- splitVariables(s)

ls.add_snippets("lua", {
	-- filetype lua
	s("require", fmt([[local {} = require "{}"]], {f(
	function(import_name)
		local parts = vim.split(import_name[1][1], ".", true)
		return parts[#parts] or ""
		-- return import_name[1] 
	end, {1}), i(1)})),
	ls.parser.parse_snippet("local function",
	"-- defined in $TM_FILENAME\nlocal $1 = function($2)\n	$0\nend"),
		ls.parser.parse_snippet("method function", "$1.$2 = function($3)\n	$0\nend"),
		})
