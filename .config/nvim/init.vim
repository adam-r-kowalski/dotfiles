call plug#begin(stdpath('data') . '/plugged')
Plug 'Rigellute/rigel'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/completion-nvim'
Plug 'vim-test/vim-test'
Plug 'rust-lang/rust.vim'
call plug#end()

set termguicolors
syntax enable
colorscheme rigel

filetype plugin indent on

let g:airline_powerline_fonts = 1
let g:mapleader = ' '

set mouse=a
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set noshowmode
set number
set relativenumber
set clipboard^=unnamed,unnamedplus

nnoremap ; :

nnoremap gb <c-o>
nnoremap <leader>i :e ~/.config/nvim/init.vim<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>g :Rg<cr>
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap gh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <leader>tn :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ts :TestSuite<CR>
nnoremap <leader>tl :TestLast<CR>
nnoremap <leader>tv :TestVisit<CR>

autocmd BufEnter * lua require'completion'.on_attach()

lua <<EOF
require'lspconfig'.rust_analyzer.setup{}
EOF
