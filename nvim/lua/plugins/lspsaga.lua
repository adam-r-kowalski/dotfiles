return {
	"nvimdev/lspsaga.nvim",
	event = "LspAttach",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		diagnostic = {
			show_source = true,
		},
		ui = {
			code_action = "󰌶",
		},
		lightbulb = {
			virtual_text = false,
		},
	},
	keys = {
		{ "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next diagnostic" },
		{ "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Prev diagnostic" },
		{ "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<cr>", desc = "Cursor diagnostic" },
		{ "<leader>a", "<cmd>Lspsaga code_action<cr>", desc = "Code action" },
		{ "K", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover documentation" },
		{ "gh", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover documentation" },
		{ "gd", "<cmd>Lspsaga goto_definition<cr>", desc = "Go to definition" },
		{ "gr", "<cmd>Lspsaga finder<cr>", desc = "Go to references" },
	},
}
