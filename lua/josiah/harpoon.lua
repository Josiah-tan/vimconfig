local M = {}

M.runLatex = function(compiler)
	vim.fn.execute(":w")
	local file_name = vim.fn.expand("%:r")
	local file_ext = vim.fn.expand("%:e")
	if file_ext == "tex" then
		compile_string = string.format("%s %s", compiler, file_name)
		combile_bib_string = string.format("bibtex %s", file_name)
		require("harpoon.term").sendCommand(1, "%s && %s && %s && %s && make\n", compile_string, combile_bib_string, compile_string, compile_string)
	else
		print(string.format("wrong file extension, received .%s, expected .tex, exiting", file_ext))
	end
end


return M
