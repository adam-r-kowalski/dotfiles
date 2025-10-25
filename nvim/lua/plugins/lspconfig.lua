return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.lsp.config("rust_analyzer", {
			settings = {
				["rust-analyzer"] = {
					cargo = {
						target = "wasm32-unknown-unknown",
					},
				},
			},
		})
	end,
}
