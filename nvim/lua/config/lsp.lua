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

-- Mason does not install clangd: after/lsp/clangd.lua runs Apple's, which matches the compiler smith runs.
vim.lsp.enable("clangd")
