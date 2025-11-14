vim.pack.add({ "https://github.com/mason-org/mason-lspconfig.nvim.git" })

require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "wgsl_analyzer", "pyright", "kotlin_lsp", "gopls", "yamlls" },
})
