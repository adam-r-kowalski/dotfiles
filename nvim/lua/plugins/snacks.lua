return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		picker = { enabled = true },
	},
	keys = {
		{
			"<leader>f",
			function()
				require("snacks").picker.files()
			end,
			desc = "Find files",
		},
	},
}
