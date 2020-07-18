call plug#begin(stdpath('data') . '/plugged')
Plug 'drewtempelmeyer/palenight.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neovim/nvim-lsp'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-lsp'
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'
Plug 'vim-test/vim-test'
Plug 'ziglang/zig.vim'
Plug 'psliwka/vim-smoothie'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
call plug#end()

set termguicolors

set background=dark
colorscheme palenight
let g:palenight_terminal_italics=1
let g:airline_theme = "palenight"
let g:airline_powerline_fonts = 1

set mouse=a
set relativenumber
set clipboard^=unnamed,unnamedplus

set inccommand=split

set splitright
set splitbelow

let g:deoplete#enable_at_startup = 1

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()

let mapleader=' '

inoremap jk <esc>
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
nnoremap <leader>p :Commands<cr>

nnoremap <silent> <leader>tn :TestNearest<cr>
nnoremap <silent> <leader>tf :TestFile<cr>
nnoremap <silent> <leader>ts :TestSuite<cr>
nnoremap <silent> <leader>tl :TestLast<cr>
nnoremap <silent> <leader>tv :TestVisit<cr>

tnoremap <expr> <c-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'

let test#custom_runners = {'zig': ['zigtest']}

lua << EOF
  local nvim_lsp = require'nvim_lsp'

  nvim_lsp.pyls_ms.setup{}
  nvim_lsp.vimls.setup{}
  nvim_lsp.jsonls.setup{}
  nvim_lsp.zls.setup{}
EOF
