call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'dag/vim-fish'
Plug 'ziglang/zig.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-test/vim-test'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'
Plug 'ycm-core/YouCompleteMe', { 'do': 'python install.py --all' }
Plug 'puremourning/vimspector', { 'do': 'python install_gadget.py --all --disable-tcl' }
Plug 'vim-airline/vim-airline'
call plug#end()

set encoding=utf-8

set termguicolors

set background=dark
colorscheme gruvbox

set clipboard^=unnamed,unnamedplus

set number relativenumber

set mouse=a

set completeopt+=popup

set expandtab shiftwidth=4

set splitright splitbelow

set signcolumn=yes

let g:asmsyntax = 'nasm'

let test#custom_runners = {'zig': ['zigtest']}

let g:rainbow_active = 1

let g:mapleader=' '

let g:ycm_language_server = 
  \ [ 
  \   {
  \     'name': 'pyls',
  \     'cmdline': [ 'pyls' ],
  \     'filetypes': [ 'python' ],
  \   },
  \   {
  \     'name': 'zls',
  \     'cmdline': [ 'zls' ],
  \     'filetypes': [ 'zig' ],
  \   }
  \ ]

let g:vimspector_enable_mappings = 'HUMAN'

let g:airline_powerline_fonts = 1

inoremap <special> <Esc> <Esc>hl

nnoremap ; :

inoremap jk <esc>
tnoremap jk <c-\><c-n>

nnoremap <c-h> <c-w>h
inoremap <c-h> <esc><c-w>h
nnoremap <c-j> <c-w>j
inoremap <c-j> <esc><c-w>j
nnoremap <c-k> <c-w>k
inoremap <c-k> <esc><c-w>k
nnoremap <c-l> <c-w>l
inoremap <c-l> <esc><c-w>l

nnoremap <leader>s :term<cr>
nnoremap <leader>i :e ~/.vimrc<cr>
nnoremap <leader>I :so %<cr>
nnoremap <leader>e :NERDTreeToggle<cr>
nnoremap <leader>v :Git<cr>

nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>g :Rg<cr>
nnoremap <leader>p :Commands<cr>
nnoremap <leader>tn :TestNearest<cr>
nnoremap <leader>tf :TestFile<cr>
nnoremap <leader>ts :TestSuite<cr>
nnoremap <leader>tl :TestLast<cr>
nnoremap <leader>tv :TestVisit<cr>

nnoremap gb <c-o>
nnoremap gd :YcmCompleter GoToDefinition<cr>
nnoremap gr :YcmCompleter GoToReferences<cr>

nnoremap <f2> :VimspectorReset<cr>

nmap s <Plug>(easymotion-overwin-f2)
