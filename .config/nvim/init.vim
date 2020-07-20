call plug#begin(stdpath('data') . '/plugged')
Plug 'drewtempelmeyer/palenight.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/completion-nvim'
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'
Plug 'vim-test/vim-test'
Plug 'ziglang/zig.vim'
Plug 'psliwka/vim-smoothie'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-commentary'
Plug 'puremourning/vimspector', {'do': './install_gadget.py --all --disable-tcl'}
call plug#end()

set termguicolors

set background=dark
colorscheme palenight
let g:palenight_terminal_italics=1
let g:airline_theme = "palenight"
let g:airline_powerline_fonts = 1

set mouse=a
set number relativenumber
set clipboard^=unnamed,unnamedplus

set expandtab
set shiftwidth=4

set inccommand=split

set splitright
set splitbelow

set signcolumn=yes

let mapleader=' '

inoremap jk <esc>
tnoremap jk <c-\><c-n>

nnoremap ; :

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

nnoremap gb <c-o>

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> g0 <cmd>lua vim.lsp.buf.document_symbol()<cr>

nnoremap <leader>e :NERDTreeToggle<cr>
nnoremap <leader>c :cclose<cr>
nnoremap <leader>i :vs ~/.config/nvim/init.vim<cr>
nnoremap <leader>I :so %<cr>
nnoremap <leader>s :term<cr>
nnoremap <leader>v :Git<cr>

nnoremap <leader>f :Files<cr>
nnoremap <leader>g :Rg<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>p :Commands<cr>

nnoremap <silent> <leader>tn :TestNearest<cr>
nnoremap <silent> <leader>tf :TestFile<cr>
nnoremap <silent> <leader>ts :TestSuite<cr>
nnoremap <silent> <leader>tl :TestLast<cr>
nnoremap <silent> <leader>tv :TestVisit<cr>

tnoremap <expr> <c-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'

let test#custom_runners = {'zig': ['zigtest']}

let g:rainbow_active = 1

autocmd BufEnter * lua require'completion'.on_attach()
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt=menuone,noinsert,noselect
set shortmess+=c

lua << EOF
  local nvim_lsp = require'nvim_lsp'

  nvim_lsp.pyls_ms.setup{}
  nvim_lsp.vimls.setup{}
  nvim_lsp.jsonls.setup{}
  nvim_lsp.zls.setup{}
EOF

let g:vimspector_enable_mappings = 'HUMAN'

nnoremap <f2> :VimspectorReset<cr>

