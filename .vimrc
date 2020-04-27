call plug#begin('~/.vim/plugged/')
Plug 'arcticicestudio/nord-vim'
Plug 'vim-test/vim-test'
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
set clipboard=unnamedplus

set splitbelow
set splitright


set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
autocmd Filetype cpp setlocal tabstop=2 shiftwidth=2 softtabstop=2

let g:python3_host_prog = "~/miniconda3/bin/python"

let mapleader = "\<space>"

let test#strategy = "vimterminal"
let test#python#runner = 'pytest'
let test#python#pytest#options = '-p no:warnings'

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

nmap <leader>tn :TestNearest<CR>
nmap <leader>tf :TestFile<CR>
nmap <leader>ts :TestSuite<CR>
nmap <leader>tl :TestLast<CR>
nmap <leader>tv :TestVisit<CR>

nnoremap <silent> <leader>f  :<C-u>Files<cr>
