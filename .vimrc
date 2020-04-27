call plug#begin('~/.vim/plugged/')
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

syntax enable
set termguicolors
set background=dark
colorscheme nord

set number
set relativenumber

set nobackup
set nowritebackup
set noswapfile

set mouse=a

set splitbelow
set splitright

let g:python3_host_prog = "~/miniconda3/bin/python"

let mapleader = "\<space>"

noremap ; :

noremap <c-h> <c-w>h
inoremap <c-h> <esc><c-w>h
noremap <c-j> <c-w>j
inoremap <c-j> <esc><c-w>j
noremap <c-k> <c-w>k
inoremap <c-k> <esc><c-w>k
noremap <c-l> <c-w>l
inoremap <c-l> <esc><c-w>l

inoremap jk <esc>
tnoremap <Esc> <C-\><C-n>
tnoremap jk <C-\><C-n>

nnoremap <leader>f :GFiles<cr> 
nnoremap <leader>F :Files<cr> 
nnoremap <leader>g :Rg<cr> 
