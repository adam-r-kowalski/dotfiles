vim.pack.add({ "https://github.com/stevearc/conform.nvim.git" })

local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		javascript = { "prettier" },
		rust = { "rustfmt" },
	},
	format_on_save = function(bufnr)
		local formatters = conform.list_formatters(bufnr)

		if #formatters > 0 then
			return {
				timeout_ms = 500,
				lsp_format = "fallback",
			}
		end

		return nil
	end,
})
