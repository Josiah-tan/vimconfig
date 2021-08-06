
local M = {}

M.setupPyright = function()
	require('lspconfig').pyright.setup{on_attach=require'completion'.on_attach}
end

M.setupClangd = function()
	require('lspconfig').clangd.setup{on_attach=require'completion'.on_attach}
end

M.sumnekoLua = function()
	local system_name
	if vim.fn.has("mac") == 1 then
		system_name = "macOS"
	elseif vim.fn.has("unix") == 1 then
		system_name = "Linux"
	elseif vim.fn.has('win32') == 1 then
		system_name = "Windows"
	else
		print("Unsupported system for sumneko")
	end
	-- print("hello world")
	-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use

	-- local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
	-- local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

	local sumneko_root_path = '/home/josiah/lua-language-server'
	local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

	local runtime_path = vim.split(package.path, ';')
	table.insert(runtime_path, "lua/?.lua")
	table.insert(runtime_path, "lua/?/init.lua")

	require'lspconfig'.sumneko_lua.setup {
		on_attach=require'completion'.on_attach,
		cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = 'LuaJIT',
					-- Setup your lua path
					path = runtime_path,
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = {'vim'},
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	}

end

return M
