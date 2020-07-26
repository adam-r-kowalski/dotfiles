call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'dag/vim-fish'
Plug 'ziglang/zig.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ycm-core/YouCompleteMe', { 'do': 'python install.py --all' }
call plug#end()

set encoding=utf-8

set termguicolors

set background=dark
colorscheme gruvbox

set clipboard^=unnamed,unnamedplus

set number relativenumber

set mouse=a

set completeopt+=popup

let g:airline_powerline_fonts = 1

let g:mapleader=' '

let g:ycm_language_server = 
  \ [ 
  \   {
  \     'name': 'zls',
  \     'cmdline': [ 'zls' ],
  \     'filetypes': [ 'zig' ],
  \   }
  \ ]

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

nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>g :Rg<cr>

nnoremap gb <c-o>
nnoremap gd :YcmCompleter GoToDefinition<cr>
nnoremap gr :YcmCompleter GoToReferences<cr>
