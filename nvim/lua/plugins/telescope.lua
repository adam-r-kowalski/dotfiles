return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<leader>/",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Telescope live grep",
		},
		{
			"<leader>b",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Telescope buffers",
		},
	},
}
