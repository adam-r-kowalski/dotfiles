vim.pack.add({
	"https://github.com/nvim-neotest/nvim-nio.git",
	"https://github.com/nvim-lua/plenary.nvim.git",
	"https://github.com/nvim-neotest/neotest.git",
})

local neotest = require("neotest")

neotest.setup({
	adapters = {
		require("rustaceanvim.neotest"),
	},
})

local test_file = function()
	neotest.run.run(vim.fn.expand("%"))
end

local test_suite = function()
	neotest.run.run({ suite = true })
end

local debug_nearest = function()
	neotest.run.run({ strategy = "dap" })
end

local debug_last = function()
	neotest.run.run_last({ strategy = "dap" })
end

vim.keymap.set("n", "<leader>tn", neotest.run.run, { desc = "Test nearest" })
vim.keymap.set("n", "<leader>dn", debug_nearest, { desc = "Debug nearest" })
vim.keymap.set("n", "<leader>tf", test_file, { desc = "Test file" })
vim.keymap.set("n", "<leader>tl", neotest.run.run_last, { desc = "Test last" })
vim.keymap.set("n", "<leader>dl", debug_last, { desc = "Debug last" })
vim.keymap.set("n", "<leader>ts", test_suite, { desc = "Test suite" })
vim.keymap.set("n", "<leader>tS", neotest.run.stop, { desc = "Test stop" })
vim.keymap.set("n", "<leader>tt", neotest.summary.toggle, { desc = "Summary toggle" })
