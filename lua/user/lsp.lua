local M = {}
-- cmp_nvim_lsp.update_capabilities is deprecated, use cmp_nvim_lsp.default_capabilities instead. See :h deprecated
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

M.setupHdlChecker = function()
	require'lspconfig'.hdl_checker.setup{capabilities = capabilities}
end

M.setupSvLangServer = function()
	require'lspconfig'.svlangserver.setup{capabilities = capabilities}
end

M.setupPylsp = function()
	require('lspconfig').pylsp.setup{capabilities = capabilities}
end

M.setupPyright = function()
	require('lspconfig').pyright.setup{
		capabilities = capabilities,
		settings = {
			python = {
				pythonPath = require("user.repl").getSourceAppend("python") --[[  "/home/user/Desktop/user/plover/benoit-pierre/retro_formatter_with_translations/.tox/dev/bin/python" ]],
			}
		}
	}
end

M.setupClangd = function()
	-- require('lspconfig').clangd.setup{on_attach=require'completion'.on_attach}
	require('lspconfig')['clangd'].setup {
		capabilities = capabilities
	}
end

M.setupArduino = function()
	require('lspconfig').arduino_language_server.setup{
		cmd = {
			-- "/mnt/c/Users/josia/arduino-language-server.exe" , "-cli-config", "/root/.arduino15/arduino-cli.yaml", "-cli", "/mnt/c/Users/josia/bin/arduino-cli" , "-clangd", "/usr/bin/clangd"
			-- "/mnt/c/Users/josia/arduino-language-server.exe" , "-cli-config", "/root/.arduino15/arduino-cli.yaml", "-cli", "/mnt/c/Users/josia/bin/arduino-cli" , "-clangd", "/usr/bin/clangd"
			-- "/mnt/c/Users/josia/arduino-language-server" , "-cli-config", "/root/.arduino15/arduino-cli.yaml", "-cli", "/usr/local/bin/arduino-cli" , "-clangd", "/usr/bin/clangd"
			"arduino-language-server",
			"-cli-config", "/path/to/arduino-cli.yaml",
			"-fqbn", "arduino:samd:nano_33_iot",
			"-cli", "arduino-cli",
			"-clangd", "clangd"
		}
	}
end


M.texlab = function()
	require('lspconfig').texlab.setup{
		-- on_attach=require'completion'.on_attach,
		capabilities = capabilities,
		settings={
			texlab={
				build={
					executable = "luatex"
				}
			}
		}
	}
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
	local sumneko_root_path = ''
	if vim.fn.has('wsl') == 1 then
		sumneko_root_path = '/mnt/c/Users/josia/lua-language-server'
	else
		sumneko_root_path = vim.fn.expand('~/lua-language-server')
	end

	local sumneko_binary = sumneko_root_path .. "/bin/" .. "/lua-language-server"

	local runtime_path = vim.split(package.path, ';')
	table.insert(runtime_path, "lua/?.lua")
	table.insert(runtime_path, "lua/?/init.lua")

	require("neodev").setup({
		--add any options here, or leave empty to use the default settings
	})

	require'lspconfig'.sumneko_lua.setup {
		capabilities = capabilities,
		-- on_attach=require'completion'.on_attach,
		cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace" -- for the neodev
				},
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
					checkThirdParty = false
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
