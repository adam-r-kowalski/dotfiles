return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	keys = {
		{ "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
	},
	config = function()
		require("oil").setup()
		vim.api.nvim_create_autocmd("VimEnter", {
			once = true,
			callback = function()
				if vim.fn.argc() > 0 then
					return
				end
				vim.schedule(function()
					local listed = vim.fn.getbufinfo({ buflisted = 1 })
					if #listed == 1 and listed[1].name == "" then
						require("oil").open()
					end
				end)
			end,
		})
	end,
}
