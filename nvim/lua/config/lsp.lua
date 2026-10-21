vim.diagnostic.config({
	virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	},
	severity_sort = true,
})

-- smith lsp is clangd from the LLVM smith compiles with, so the editor sees what the build sees. The smith plugin
-- (plugins/smith.lua) defines its config; it replaces clangd, so clangd stays off.
vim.lsp.enable("smith")
