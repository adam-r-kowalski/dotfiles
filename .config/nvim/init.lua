require('plugins')

local o = vim.o
local wo = vim.wo
local bo = vim.bo
local g = vim.g
local cmd = vim.cmd
local map = vim.api.nvim_set_keymap

o.termguicolors = true
o.mouse = 'a'
o.clipboard = [[unnamed,unnamedplus]]
o.inccommand = 'nosplit'
o.expandtab = true
o.showmode = false
o.completeopt = [[menuone,noinsert,noselect]]
wo.signcolumn = 'yes'
wo.number = true
wo.relativenumber = true
bo.swapfile = false

g.mapleader = ' '
g.floaterm_width = 0.8
g.floaterm_height = 0.8

cmd("let g:test#custom_runners = {'zig': ['Zigtest']}")

cmd('colorscheme nord')
cmd('autocmd BufWritePost plugins.lua PackerCompile')
cmd('au BufNewFile,BufRead *.lang setlocal ft=clojure')
cmd("autocmd BufEnter * lua require 'completion'.on_attach()")

local options = {noremap=true, silent=true}
map("i", "<tab>", "pumvisible() ? '<c-n>' : '<tab>'", {noremap=true, expr=true})
map("i", "<s-tab>", "pumvisible() ? '<c-p>' : '<s-tab>'", {noremap=true, expr=true})
map("i", "jk", "<esc>", options)
map("n", ";", ":", {noremap=true})
map("n", "<leader>f", "<cmd>lua require('telescope.builtin').find_files()<cr>", options)
map("n", "<leader>.", "<cmd>lua require('telescope.builtin').file_browser()<cr>", options)
map("n", "<leader>g", "<cmd>lua require('telescope.builtin').live_grep()<cr>", options)
map("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>", options)
map("n", "<leader>x", "<cmd>lua require('telescope.builtin').commands()<cr>", options)
map("n", "<leader>d", "<cmd>lua require('telescope.builtin').lsp_diagnostics()<cr>", options)
map("n", "<leader>s", "<cmd>luafile %<cr>", options)
map("n", "<leader>i", "<cmd>edit ~/.config/nvim/init.lua <cr>", options)
map("n", "<leader>pi", "<cmd>PackerInstall<cr>", options)
map("n", "<leader>pc", "<cmd>PackerClean<cr>", options)
map("n", "gb", "<c-o>", options)
map("n", "gn", "<c-^>", options)
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", options)
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", options)
map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<cr>", options)
map("n", "gs", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", options)
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", options)
map("n", "<c-h>", "<c-w>h", options)
map("n", "<c-j>", "<c-w>j", options)
map("n", "<c-k>", "<c-w>k", options)
map("n", "<c-l>", "<c-w>l", options)
map("n", "<leader>tn", "<cmd>TestNearest<cr>", options)
map("n", "<leader>tf", "<cmd>TestFile<cr>", options)
map("n", "<leader>tl", "<cmd>TestLast<cr>", options)
map("n", "<leader>tv", "<cmd>TestVisit<cr>", options)
map("n", "<leader>ts", "<cmd>TestSuite<cr>", options)

local lualine = require('lualine')
lualine.options.theme = 'nord'
lualine.status()

local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'

local on_attach = function(client, bufnr)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

if not lspconfig.zls then
  configs.zls = {
    default_config = {
      cmd = {'/Users/adamkowalski/zls/zig-cache/bin/zls'};
      filetypes = {'zig'};
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
      end;
      settings = {};
    };
  }
end

lspconfig.zls.setup{ on_attach = on_attach }

require('nvim-autopairs').setup()

