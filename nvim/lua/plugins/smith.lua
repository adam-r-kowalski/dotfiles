-- smith (https://github.com/adam-r-kowalski/smith): the .smith file type and its tree-sitter highlighting, the "smith"
-- config for vim.lsp (smith lsp, enabled in config/lsp.lua) and, with nvim-dap, the "smith" adapter (smith dap). The
-- parser is compiled with smith cc the first time a .smith file opens. It needs smith on the PATH.
vim.pack.add({ "git@github.com:adam-r-kowalski/smith" })
