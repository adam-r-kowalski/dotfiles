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
	keys = function()
		local snacks = require("snacks")
		local function zen()
			snacks.zen()
		end
		local function lazygit()
			snacks.lazygit()
		end
		return {
			{ "<leader>f", snacks.picker.files, desc = "Files" },
			{ "<leader>/", snacks.picker.grep, desc = "Grep" },
			{ "<leader>b", snacks.picker.buffers, desc = "Buffers" },
			{ "<leader>z", zen, desc = "Zen" },
			{ "<leader>g", lazygit, desc = "Git" },
		}
	end,
}
