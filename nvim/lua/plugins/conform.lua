vim.pack.add({ "https://github.com/stevearc/conform.nvim.git" })

local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		javascript = { "prettier" },
		rust = { "rustfmt" },
		c = { "smith_fmt" },
		cpp = { "smith_fmt" },
		objc = { "smith_fmt" },
		objcpp = { "smith_fmt" },
		smith = { "smith_fmt" },
	},
	formatters = {
		-- smith fmt with arguments is clang-format, from the LLVM smith compiles with: the style is the project's
		-- .clang-format, and a file with none is left as it is.
		smith_fmt = {
			command = "smith",
			args = { "fmt", "--assume-filename=$FILENAME", "--fallback-style=none" },
			stdin = true,
		},
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
