return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		animate = { enabled = true },
		bigfile = { enabled = true },
		picker = { enabled = true },
		dim = { enabled = true },
		image = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		lazygit = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		zen = {
			enabled = true,
			toggles = {
				dim = true,
				git_signs = true,
				diagnostics = true,
			},
			win = {
				backdrop = {
					transparent = false,
					blend = 99,
				},
			},
		},
	},
	keys = {
		{
			"<leader>f",
			function()
				require("snacks").picker.files()
			end,
			desc = "Files",
		},
		{
			"<leader>/",
			function()
				require("snacks").picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>b",
			function()
				require("snacks").picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>z",
			function()
				require("snacks").zen()
			end,
			desc = "Zen",
		},
		{
			"<leader>g",
			function()
				require("snacks").lazygit()
			end,
			desc = "Git",
		},
	},
}
