call plug#begin(stdpath('data') . '/plugged')
Plug 'Rigellute/rigel'
Plug 'vim-airline/vim-airline'
Plug 'ziglang/zig.vim'
Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/completion-nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'luochen1990/rainbow'
Plug 'vim-test/vim-test'
Plug 'tpope/vim-repeat'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'dag/vim-fish'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
call plug#end()

set termguicolors
set background=dark
colorscheme rigel

let g:airline_powerline_fonts = 1

set clipboard^=unnamed,unnamedplus

set number relativenumber

set splitright splitbelow

let g:mapleader=' '

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

autocmd BufEnter * lua require'completion'.on_attach()

set completeopt=menuone,noinsert,noselect

set shortmess+=c

set signcolumn=yes

let g:rainbow_active = 1

set inccommand=nosplit

let test#strategy = "neovim"
let test#python#pytest#options = '-s'
let test#custom_runners = {'zig': ['zigtest']}

let g:asmsyntax = 'nasm'

set mouse=a

set nobackup nowritebackup

set expandtab shiftwidth=4

let g:NERDTreeWinPos='right'

inoremap jk <esc>
tnoremap jk <c-\><c-n>

nnoremap ; :

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

nnoremap <leader>i :e ~/.config/nvim/init.vim<cr>
nnoremap <leader>I :so %<cr>

nnoremap <leader>e :NERDTreeToggle<cr>

nnoremap <leader>v :Git<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>g :Rg<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>p :Commands<cr>

nnoremap <leader>tn :TestNearest<cr>
nnoremap <leader>tf :TestFile<cr>
nnoremap <leader>tl :TestLast<cr>
nnoremap <leader>ts :TestSuite<cr>
nnoremap <leader>tv :TestVisit<cr>

nnoremap <silent> gb <c-o>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gH <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gt <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gs <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gS <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nmap s <Plug>(easymotion-overwin-f2)

lua << EOF
    local nvim_lsp = require'nvim_lsp'
    nvim_lsp.zls.setup{}
    nvim_lsp.pyls.setup{}
    nvim_lsp.vimls.setup{}
EOF
