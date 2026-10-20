-- nvim-treesitter's main branch installs parsers and queries; neovim itself highlights (vim.treesitter.start) and
-- nvim-treesitter indents. It builds parsers with the tree-sitter command (brew install tree-sitter-cli) and the C
-- compiler. The old master branch stopped at neovim 0.11: on 0.12 its query directives crashed rendering hover's markdown.
local hooks = function(ev)
	local name, kind = ev.data.spec.name, ev.data.kind
	if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
		vim.cmd("TSUpdate")
	end
end

vim.api.nvim_create_autocmd("PackChanged", { callback = hooks })

vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter.git", version = "main" } })

local treesitter = require("nvim-treesitter")
treesitter.install({ "lua", "rust", "wgsl", "html", "javascript", "css", "styled", "c", "zig" })

-- Highlight and indent every buffer whose language has a parser. A language with no parser yet is installed the first
-- time its filetype opens, as auto_install did, and is highlighted from the next time.
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local language = vim.treesitter.language.get_lang(args.match) or args.match
		if not vim.treesitter.language.add(language) then
			if vim.list_contains(treesitter.get_available(), language) then
				treesitter.install(language)
			end
			return
		end
		vim.treesitter.start(args.buf, language)
		vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
