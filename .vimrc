call plug#begin('~/.vim/plugged')
Plug 'sainnhe/gruvbox-material'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'dag/vim-fish'
call plug#end()

set encoding=UTF-8

set termguicolors

set background=dark
let g:gruvbox_material_background = 'medium'
colorscheme gruvbox-material

set clipboard^=unnamed,unnamedplus

let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox_material'
let g:gruvbox_material_enable_italic = 1

hi Comment cterm=NONE

let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

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

let g:mapleader=' '

nnoremap <leader>s :term<cr>
nnoremap <leader>i :e ~/.vimrc<cr>
nnoremap <leader>I :so %<cr>
nnoremap <leader>I :so %<cr>
nnoremap <leader>e :NERDTreeToggle<cr>


