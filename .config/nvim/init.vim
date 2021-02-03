call plug#begin(stdpath('data') . '/plugged')
Plug 'ghifarit53/tokyonight-vim'
Plug 'vim-airline/vim-airline'
Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/completion-nvim'
Plug 'vim-test/vim-test'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'tpope/vim-markdown'
Plug 'guns/vim-sexp'
Plug 'voldikss/vim-floaterm'
Plug 'jiangmiao/auto-pairs'
Plug 'kien/rainbow_parentheses.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'rust-lang/rust.vim'
Plug 'guns/vim-clojure-static'
Plug 'ziglang/zig.vim'
call plug#end()

let g:airline_powerline_fonts = 1
let g:mapleader = ' '
let test#strategy = "floaterm"
let test#custom_runners = {'zig': ['Zigtest']}
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
let g:markdown_fenced_languages = ['clojure']
let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1

set termguicolors
set mouse=a
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set noshowmode
set number
set relativenumber
set clipboard^=unnamed,unnamedplus
set expandtab

syntax enable
colorscheme tokyonight

filetype plugin indent on

nnoremap ; :
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap gb <c-o>
nnoremap gn <c-^>
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap gh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <leader>i :e ~/.config/nvim/init.vim<cr>
nnoremap <leader>f :FloatermNew fzf<cr>
nnoremap <leader>e :FloatermNew nnn -e<cr>
nnoremap <leader>g :Rg<cr>
nnoremap <leader>tn :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ts :TestSuite<CR>
nnoremap <leader>tl :TestLast<CR>
nnoremap <leader>tv :TestVisit<CR>
nnoremap <leader>v :Git<CR>
nnoremap <leader>sc :FloatermNew<CR>
nnoremap <leader>st :FloatermToggle<CR>
nnoremap <leader>sn :FloatermNext<CR>
nnoremap <leader>sp :FloatermPrev<CR>
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
inoremap jk <esc>

autocmd BufEnter * lua require'completion'.on_attach()
autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

lua require('lsp_config')

