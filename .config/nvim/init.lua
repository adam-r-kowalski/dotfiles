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
o.completeopt = [[menuone,noselect]]
o.updatetime = 300
o.hidden = true
o.shiftwidth = 2
wo.signcolumn = 'yes'
wo.number = true
wo.relativenumber = true
bo.swapfile = false

g.mapleader = ' '
g.floaterm_width = 0.8
g.floaterm_height = 0.8
g.nvim_tree_side = 'right'

cmd("let g:test#custom_runners = {'zig': ['Zigtest']}")
cmd([[
let test#python#runner = 'pytest'
let test#python#pytest#executable = 'python -m pytest'
let test#python#pytest#options = '-s'
]])

-- cmd('au ColorScheme * hi Normal ctermbg=none guibg=none')

cmd('syntax on')
require('moonlight').set()
cmd('autocmd BufWritePost plugins.lua PackerCompile')
cmd('au BufNewFile,BufRead *.ra setlocal ft=clojure')


local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

local options = {noremap=true, silent=true}
map("i", "<tab>", "v:lua.tab_complete()", {expr=true})
map("s", "<tab>", "v:lua.tab_complete()", {expr=true})
map("i", "<s-tab>", "v:lua.s_tab_complete()", {expr=true})
map("s", "<s-tab>", "v:lua.s_tab_complete()", {expr=true})
map("i", "<cr>", "compe#confirm('<cr>')", {silent=true, expr=true})
map("i", "jk", "<esc>", options)
map("t", "jk", "<c-\\><c-n>", options)
map("n", ";", ":", {noremap=true})
map("n", "<leader>f", "<cmd>lua require('telescope.builtin').find_files()<cr>", options)
map("n", "<leader>.", "<cmd>lua require('telescope.builtin').file_browser()<cr>", options)
map("n", "<leader>g", "<cmd>lua require('telescope.builtin').live_grep()<cr>", options)
map("n", "<leader>bl", "<cmd>lua require('telescope.builtin').buffers()<cr>", options)
map("n", "<leader>bd", "<cmd>bd!<cr>", options)
map("n", "<leader>x", "<cmd>lua require('telescope.builtin').commands()<cr>", options)
map("n", "<leader>dl", "<cmd>lua require('lspsaga.diagnostic').show_line_diagnostics()<cr>", options)
map("n", "<leader>dc", "<cmd>lua require('lspsaga.diagnostic').show_cursor_diagnostics()<cr>", options)
map("n", "<leader>dp", "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev()<cr>", options)
map("n", "<leader>dn", "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<cr>", options)
map("n", "<leader>sd", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", options)
map("n", "<leader>sw", "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>", options)
map("n", "<leader>sf", "<cmd>luafile %<cr>", options)
map("n", "<leader>i", "<cmd>edit ~/.config/nvim/init.lua <cr>", options)
map("n", "<leader>e", ":NvimTreeFindFile<cr>", options)
map("n", "<leader>pi", "<cmd>PackerInstall<cr>", options)
map("n", "<leader>pc", "<cmd>PackerClean<cr>", options)
map("n", "gb", "<c-o>", options)
map("n", "gn", "<c-^>", options)
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", options)
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", options)
map("n", "gf", "<cmd>lua require('lspsaga.provider').lsp_finder()<cr>", options)
map("n", "gh", "<cmd>lua require('lspsaga.hover').render_hover_doc()<cr>", options)
map("n", "gs", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", options)
map("n", "<leader>a", "<cmd>lua require('lspsaga.codeaction').code_action()<cr>", options)
map("n", "<leader>rn", "<cmd>lua require('lspsaga.rename').rename()<cr>", options)
map("n", "<c-h>", "<c-w>h", options)
map("n", "<c-j>", "<c-w>j", options)
map("n", "<c-k>", "<c-w>k", options)
map("n", "<c-l>", "<c-w>l", options)
map("n", "<leader>tn", "<cmd>TestNearest<cr>", options)
map("n", "<leader>tf", "<cmd>TestFile<cr>", options)
map("n", "<leader>tl", "<cmd>TestLast<cr>", options)
map("n", "<leader>tv", "<cmd>TestVisit<cr>", options)
map("n", "<leader>ts", "<cmd>TestSuite<cr>", options)
map("n", "<leader>o", "<cmd>SymbolsOutline<cr>", options)
-- map("n", "<leader>c", "<cmd>term zig build run -Drelease-fast -- examples/start.ra; temp/code<cr>", options)
map("n", "<leader>c", "<cmd>term zig build run -- examples/start.ra; temp/code<cr>", options)
map("n", "<leader>v", "<cmd>term lazygit<cr>", options)
map("n", "s", "<Plug>(easymotion-s2)", {})
map("n", "<tab>", "<cmd>BufferLineCycleNext<CR>", options)
map("n", "<s-tab>", "<cmd>BufferLineCyclePrev<CR>", options)

local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'

local on_attach = function(client, _)
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      signs = true,
      update_in_insert = false,
    }
  )
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=#4B5263
      hi LspReferenceText cterm=bold ctermbg=red guibg=#4B5263
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=#4B5263
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end

  if client.resolved_capabilities.document_formatting then
    cmd [[augroup Format]]
    cmd [[autocmd! * <buffer>]]
    cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
    cmd [[augroup END]]
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

local lsp_install = require('lspinstall')

lsp_install.setup()

lspconfig.lua.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim', 'use' }
      }
    },
    workspace = {
    library = {
      [vim.fn.expand('$VIMRUNTIME/lua')] = true,
      [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      }
    }
  }
}

lspconfig.python.setup { on_attach = on_attach }
lspconfig.rust.setup { on_attach = on_attach }

if not lspconfig.clangd then
  configs.clangd = {
    default_config = {
      cmd = {'clangd'};
      filetypes = {'c', 'c++', 'cpp', 'h', 'hpp'};
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
      end;
      settings = {};
    };
  }
end

lspconfig.clangd.setup{ on_attach = on_attach }

require('nvim-autopairs').setup()

require('neoscroll').setup()

require('lspkind').init()

require('bufferline').setup{ options = { always_show_bufferline = false }}

local saga = require('lspsaga')
saga.init_lsp_saga {
  finder_action_keys = {
    open = '<cr>'
  }
}

require('lualine').setup{options = {theme='moonlight'}}

require('compe').setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;
  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
  };
}

cmd([[highlight link CompeDocumentation NormalFloat]])

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 1000,
  },
}

vim.g.symbols_outline = {
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = true,
  position = 'right',
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = true,
  keymaps = {
    close = "<Esc>",
    goto_location = "<Cr>",
    focus_location = "o",
    hover_symbol = "<C-space>",
    rename_symbol = "r",
    code_actions = "a",
  },
  lsp_blacklist = {},
}
