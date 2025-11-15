vim.pack.add({ "https://github.com/nvim-mini/mini.files.git" })

local MiniFiles = require("mini.files")

MiniFiles.setup({
	mappings = {
		close = "q",
		go_in = "L",
		go_in_plus = "l",
		go_out = "h",
		go_out_plus = "H",
		mark_goto = "'",
		mark_set = "m",
		reset = "<BS>",
		reveal_cwd = "@",
		show_help = "g?",
		synchronize = "=",
		trim_left = "<",
		trim_right = ">",
	},
})

vim.keymap.set("n", "-", function()
	local bufname = vim.api.nvim_buf_get_name(0)
	-- Don't pass minifiles:// buffer names, use the file path or nil instead
	if not bufname:match("^minifiles://") then
		MiniFiles.open(bufname, false)
		MiniFiles.reveal_cwd()
	else
		-- If already in mini.files, just close and reopen at cwd
		MiniFiles.close()
		MiniFiles.open(vim.fn.getcwd(), false)
	end
end)
