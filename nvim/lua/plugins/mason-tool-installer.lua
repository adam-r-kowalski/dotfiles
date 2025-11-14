vim.pack.add({ "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim.git" })

require("mason-tool-installer").setup({
	ensure_installed = { "stylua", "black", "prettier" },
})
