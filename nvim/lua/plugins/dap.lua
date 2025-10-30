return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"williamboman/mason.nvim",
		"mfussenegger/nvim-dap",
		"jay-babu/mason-nvim-dap.nvim",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		require("mason-nvim-dap").setup({
			ensure_installed = { "python", "codelldb", "delve" },
		})

		local dap, dapui = require("dap"), require("dapui")
		dapui.setup()

		-- Set breakpoint icons
		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "◆", texthl = "DapBreakpoint", linehl = "", numhl = "" }
		)
		vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped", linehl = "debugPC", numhl = "" })

		-- Set colors (add to your colorscheme or here)
		vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e51400" })
		vim.api.nvim_set_hl(0, "DapStopped", { fg = "#00ff00" })

		-- Rust/C/C++ configuration with codelldb
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
				args = { "--port", "${port}" },
			},
		}

		dap.configurations.rust = {
			{
				name = "Launch",
				type = "codelldb",
				request = "launch",
				program = function()
					-- Get the project name from Cargo.toml or use the directory name
					local cwd = vim.fn.getcwd()
					local project_name = vim.fn.fnamemodify(cwd, ":t")
					return cwd .. "/target/debug/" .. project_name
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}

		-- Listeners...
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
	end,
	keys = function()
		local dap = require("dap")
		local dapui = require("dapui")
		return {
			{ "<leader>db", dap.toggle_breakpoint, desc = "Toggle breakpoint" },
			{ "<leader>dc", dap.continue, desc = "Continue" },
			{ "<leader>di", dap.step_into, desc = "Step into" },
			{ "<leader>do", dap.step_over, desc = "Step over" },
			{ "<leader>dO", dap.step_out, desc = "Step out" },
			{ "<leader>dr", dap.repl.open, desc = "Open REPL" },
			{ "<leader>dl", dap.run_last, desc = "Run last" },
			{ "<leader>dt", dapui.toggle, desc = "Toggle DAP UI" },
		}
	end,
}
