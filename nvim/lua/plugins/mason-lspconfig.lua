return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	opts = {
		ensure_installed = { "lua_ls", "rust_analyzer", "wgsl_analyzer", "pyright", "kotlin_lsp", "gopls" },
	},
}
