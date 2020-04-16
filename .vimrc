call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'clangd/coc-clangd', {'do': 'yarn install --frozen-lockfile'}
Plug 'weirongxu/coc-explorer', {'do': 'yarn install --frozen-lockfile'}
Plug 'ryanoasis/vim-devicons'
call plug#end()

set nocompatible

set encoding=UTF-8

syntax enable

set termguicolors
let g:nord_uniform_diff_background = 1
colorscheme nord

set hidden
set nowrap

set backspace=indent,eol,start

set relativenumber
set noshowmode
set laststatus=2

set hlsearch
set incsearch

set nobackup
set nowritebackup
set noswapfile

set tabstop=2
set autoindent
set copyindent
set shiftwidth=2
set shiftround

let mapleader="\<space>"
let maplocalleader=","

filetype plugin indent on

set mouse=a
set clipboard^=unnamed,unnamedplus

set signcolumn=yes

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nnoremap ; :

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> gs :<C-u>CocCommand clangd.switchSourceHeader<cr>
nmap gb <C-o>
nmap <leader>rn <Plug>(coc-rename)
nnoremap <silent> <leader>e :<C-u>CocCommand explorer<cr>
nnoremap <silent> <leader>o :<C-u>CocList outline<cr>
nnoremap <silent> <leader>s :<C-u>CocList -I symbols<cr>
nnoremap <silent> <leader>f :<C-u>CocList files<cr>
nnoremap <silent> <leader>b :<C-u>CocList buffers<cr>
nnoremap <silent> <leader>g :<C-u>CocList grep<cr>
nnoremap <silent> <leader>i :<C-u>CocCommand clangd.symbolInfo<cr>
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <leader>d :Dispatch<CR>
nnoremap <leader>D :Focus 
nnoremap <leader>qc :cclose<CR> 
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

nmap <silent> <localleader>c <Plug>VimspectorContinue
nmap <silent> <localleader>s <Plug>VimspectorStop
nmap <silent> <localleader>r <Plug>VimspectorRestart
nmap <silent> <localleader>k :call vimspector#Reset()<CR>
nmap <silent> <localleader>p <Plug>VimspectorPause
nmap <silent> <localleader>t <Plug>VimspectorToggleBreakpoint
nmap <silent> <localleader>f <Plug>VimspectorAddFunctionBreakpoint
nmap <silent> <localleader>o <Plug>VimspectorStepOver
nmap <silent> <localleader>i <Plug>VimspectorStepInto
nmap <silent> <localleader>u <Plug>VimspectorStepOut

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

tnoremap <ESC> <C-\><C-n>
tnoremap jk <C-\><C-n>

imap jk <Esc>

autocmd CursorHold * silent call CocActionAsync('highlight')

let g:cpp_concepts_highlight = 1

nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
set timeoutlen=500

let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
