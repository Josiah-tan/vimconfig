local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'sumneko_lua',
})

lsp.configure('pyright', {
	settings = {
		python = {
			pythonPath = require("user.repl").getSourceAppend("python") --[[  "/home/user/Desktop/user/plover/benoit-pierre/retro_formatter_with_translations/.tox/dev/bin/python" ]],
		}
	}
})

lsp.configure('sumneko_lua', {
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			}
		}
	}
})

require("neodev").setup({ -- for function signature lua
	--add any options here, or leave empty to use the default settings
})

-- lsp.configure('arduino-language-server', {
-- 	cmd = {
-- 		-- "/mnt/c/Users/josia/arduino-language-server.exe" , "-cli-config", "/root/.arduino15/arduino-cli.yaml", "-cli", "/mnt/c/Users/josia/bin/arduino-cli" , "-clangd", "/usr/bin/clangd"
-- 		-- "/mnt/c/Users/josia/arduino-language-server.exe" , "-cli-config", "/root/.arduino15/arduino-cli.yaml", "-cli", "/mnt/c/Users/josia/bin/arduino-cli" , "-clangd", "/usr/bin/clangd"
-- 		-- "/mnt/c/Users/josia/arduino-language-server" , "-cli-config", "/root/.arduino15/arduino-cli.yaml", "-cli", "/usr/local/bin/arduino-cli" , "-clangd", "/usr/bin/clangd"
-- 		"arduino-language-server",
-- 		"-cli-config", "/path/to/arduino-cli.yaml",
-- 		"-fqbn", "arduino:samd:nano_33_iot",
-- 		"-cli", "arduino-cli",
-- 		"-clangd", "clangd"
-- 	}
-- })

lsp.configure('texlab', {
	settings={
		texlab={
			build={
				executable = "luatex"
			}
		}
	}
})


require("user.completion")

lsp.set_preferences({
    suggest_lsp_servers = false,
	set_lsp_keymaps = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})

require("user.snippets")
