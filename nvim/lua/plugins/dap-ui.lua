vim.pack.add({
	"https://github.com/mfussenegger/nvim-dap.git",
	"https://github.com/nvim-neotest/nvim-nio.git",
	"https://github.com/rcarriga/nvim-dap-ui.git",
})

require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")
dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
vim.keymap.set("n", "<f10>", dap.step_into, { desc = "Step into" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
vim.keymap.set("n", "<f9>", dap.step_over, { desc = "Step over" })
vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
vim.keymap.set("n", "<f7>", dap.step_out, { desc = "Step out" })
vim.keymap.set("n", "<leader>db", dap.step_back, { desc = "Step back" })
vim.keymap.set("n", "<f6>", dap.step_back, { desc = "Step back" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
vim.keymap.set("n", "<f8>", dap.continue, { desc = "Continue" })
vim.keymap.set("n", "<leader>dd", dap.disconnect, { desc = "Disconnect" })
