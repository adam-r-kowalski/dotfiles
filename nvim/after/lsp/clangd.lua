-- C, C++ and Objective-C build through smith (https://github.com/adam-r-kowalski/smith), which runs Apple's clang on
-- macOS, so the editor runs Apple's clangd to match: /usr/bin/clangd forwards to the Xcode toolchain's, and it
-- understands the Apple-only flags in Apple clang's compile commands, which upstream clangd rejects.
-- --query-driver lets clangd ask smith for its target and system headers, exactly as the build sees them, when
-- compile_commands.json names smith. It lives in after/lsp/ so that it overrides nvim-lspconfig's lsp/clangd.lua.
return {
	cmd = { "/usr/bin/clangd", "--query-driver=" .. vim.env.HOME .. "/.local/bin/smith*" },
}
