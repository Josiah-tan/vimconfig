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
				-- virt_text = {{"<- current choice", "NonTest"}},
			}
		}
	}
}

vim.keymap.set({"i", "s"}, "<M-s>", require "luasnip.extras.select_choice")

-- expansion key
vim.keymap.set({"i", "s"}, "<M-e>", function ()
	if ls.expandable() then
		ls.expand_or_jump()
	end
end, {silent = true})

-- jumps to next item within the snippet
vim.keymap.set({"i", "s"}, "<M-k>", function ()
	if ls.jumpable(1) then
		ls.jump(1)
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
vim.keymap.set({"i", "s"}, "<M-l>", function ()
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

ls.cleanup()
-- vs**** style snippets... lol (ls.parser.parse_snippet)
ls.add_snippets("all", {
	-- any filetype
	-- ls.parser.parse_snippet("expand", "my first snippet ever!"),
	-- s("todo", {
	-- 	c(1, {
	-- 		t "TODO(user): ",
	-- 		t "FIXME(user): ",
	-- 		t "TODONT(user): ",
	-- 		t "TODO(anybody please help me): ",
	-- 	})
	-- }
	-- ),
	s("time", { -- trying to understand the function node
		f(function() return os.date "%D - %H:%M" end)
	}),
	s("same test",	fmt([[example: {}, function: {}]], {i(1), rep(1)}))
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



local python_function_fmt = function(method_name)
	local use_method_name = function()
		if (method_name) then
			return {
				t(method_name),
				i(1, "parameter"),
				i(2, "// body")
			}
		else
			return {
				i(1,"method_name"),
				i(2, "parameter"),
				i(3, "// body")
			}
		end
	end
	return sn(nil,
	fmt(
	[[
	{}(self, {}):
			{}
	]],
		use_method_name()
	)
	)
end

ls.add_snippets("python", {
	s("print",
	fmt(
	[[
	print(f"{} = {{{}}}")
	]],
	{
		i(1, "something"),
		rep(1)
	}
	)),
	s("for range",
	fmt(
	[[
	for {} in range({}):
		{}
	]],
	{
		i(1, "i"),
		i(2, "n"),
		i(3, "code here")
	}
	)),
	s("cls",
	fmt(
	[[
	class {}:
		def {}
	]],
	{
		i(1, "ClassName"),
		c(2, {
			python_function_fmt(),
			python_function_fmt("__init__"),
			python_function_fmt("__call__"),
		})
	}
	)),
	s("clsi",
	fmt(
	[[
	class {}:
		def {}
	]],
	{
		i(1, "ClassName"),
		c(2, {
			python_function_fmt("__init__"),
			python_function_fmt("__call__"),
			python_function_fmt(),
		})
	}
	)),
	s("comment",
	fmt(
		[[
		"""
		{}
		
		Args:
			{}
			
		Returns:
			{}
		"""
		{}
		]],
		{
			i(1, "brief description"),
			i(2, "argument1: description"),
			i(3, "returns"),
			i(0)
		})
	),
	s("comment arguments",
	fmt(
		[[
		"""
		{}
		
		Args:
			{}
		"""
		{}
		]],
		{
			i(1, "brief description"),
			i(2, "argument1: description"),
			i(0)
		})
	),
	s("comment returns",
	fmt(
		[[
		"""
		{}
		
		Returns:
			{}
		"""
		{}
		]],
		{
			i(1, "brief description"),
			i(2, "returns"),
			i(0)
		})
	)
})

ls.add_snippets("org", {
	s("source",
	fmt(
	[[
	#+BEGIN_SRC {}
	{}
	#+END_SRC
	]],
	{
		i(1, "language"),
		i(2, "code here"),
	}
	))
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
	local sep = ","
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
	s("comment",
	fmt(
	[[
	/*
		@brief:
		{}
		@param:
		{}
		@return:
		{}
	*/
	]],
	{
		i(1, "brief description"),
		i(2, "parameters"),
		i(3, "returns"),
	}
	)),
	s("for",
	fmt(
	[[
	for (int {} = {}; {} < {}; {}++)
	{{
		{}
	}}
	]],
	{
		i(1, "i"),
		i(2, "0"),
		rep(1),
		i(3, "n"),
		rep(1),
		i(4, "// code here")
	}
	)),
	s("forb",
	fmt(
	[[
	for (int {} = {} - {}; {} >= {}; {}--)
	{{
		{}
	}}
	]],
	{
		i(1, "i"),
		i(2, "n"),
		i(3, "1"),
		rep(1),
		i(4, "0"),
		rep(1),
		i(5, "// code here")
	}
	)),
	s("fort",
	fmt(
	[[
	for (int {} = {} - {}; ~{}; {}--)
	{{
		{}
	}}
	]],
	{
		i(1, "i"),
		i(2, "n"),
		i(3, "1"),
		rep(1),
		rep(1),
		i(4, "// code here")
	}
	)),
	s("print",
	fmt(
	[[
	std::cout << "{} = " << {} << std::endl;
	]],
	{
		i(1, "variable"),
		rep(1),
	}
	)),
	s("cout",
	fmt(
	[[
	std::cout << "{} = " << {} << std::endl;
	]],
	{
		i(1, "variable"),
		rep(1),
	}
	)),
	s("break",
	fmt(
	[[
	std::cout << "##########" << std::endl;
	]],
	{}
	)),
})

ls.add_snippets("cpp", {
	s("cls",
	fmt(
	[[
	class {}{{
		public:
			{} {}({}){{
				{}
			}}
	}};
	]],
	{
		i(1, "ClassName"),
		i(2, "void"),
		i(3, "methodName"),
		i(4, "int n"),
		i(5, "// code")
	}
	)),
	s("clsi",
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
		rep(1),
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

ls.add_snippets("markdown", {
	s("link",
	fmt(
	[[
	[{}]({})
	]],
	{
		i(1, "filename"),
		i(2, "link"),
	}
	))
})

ls.add_snippets("lua", {
	s("require", fmt([[local {} = require "{}"]], {f(
	function(import_name)
		local parts = vim.split(import_name[1][1], ".", true)
		return parts[#parts] or ""
		-- return import_name[1] 
	end, {1}), i(1)})),
	ls.parser.parse_snippet("local function",
	"-- local $1 = function($2)\n	$0\nend"),
		ls.parser.parse_snippet("method function", "$1.$2 = function($3)\n	$0\nend"),
		})


