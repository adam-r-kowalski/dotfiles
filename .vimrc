call plug#begin('~/.vim/plugged/')
Plug 'arcticicestudio/nord-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'vim-test/vim-test'
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

set hidden
set shortmess+=c
set signcolumn=yes

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
autocmd Filetype cpp setlocal tabstop=2 shiftwidth=2 softtabstop=2

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

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

nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent> <leader>f  :<C-u>CocList files<cr>
nnoremap <silent> <leader>b  :<C-u>CocList buffers<cr>
nnoremap <silent> <leader>g  :<C-u>CocList grep<cr>
