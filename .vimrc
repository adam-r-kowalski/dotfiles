set nocompatible

call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-pairs', {'do': 'yarn install --frozen-lockfile'}
Plug 'clangd/coc-clangd', {'do': 'yarn install --frozen-lockfile'}
Plug 'weirongxu/coc-explorer', {'do': 'yarn install --frozen-lockfile'}
Plug 'puremourning/vimspector'
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'adam-r-kowalski/vim-test'
Plug 'yuttie/comfortable-motion.vim'
Plug 'easymotion/vim-easymotion'
Plug 'justinmk/vim-sneak'
Plug 'scrooloose/nerdcommenter'
Plug 'jpalardy/vim-slime'
Plug 'tpope/vim-dispatch'
Plug 'liuchengxu/vim-which-key'
Plug 'tpope/vim-abolish'
call plug#end()

set encoding=UTF-8

syntax enable

set termguicolors
let g:nord_uniform_diff_background = 1
colorscheme nord

set hidden
set nowrap

set backspace=indent,eol,start

set number
set relativenumber
set noshowmode
set laststatus=2

set hlsearch
set incsearch

set nobackup
set nowritebackup
set noswapfile

autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype cpp setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

set tabstop=4
set shiftwidth=4
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
nnoremap <silent> <leader>tn :TestNearest<CR>
nnoremap <silent> <leader>tf :TestFile<CR>
nnoremap <silent> <leader>ts :TestSuite<CR>
nnoremap <silent> <leader>tl :TestLast<CR>
nnoremap <silent> <leader>tv :TestVisit<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <leader>d :Dispatch<CR>
nnoremap <leader>D :Focus 
nnoremap <leader>qc :cclose<CR> 
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

xmap <localleader>e <Plug>SlimeRegionSend
nmap <localleader>e <Plug>SlimeParagraphSend
nmap <localleader>E <Plug>SlimeConfig
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
nnoremap <localleader>gd :Gvdiffsplit!<CR>
nnoremap <localleader>gl :diffget //2<CR>
nnoremap <localleader>gm :diffget //3<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

tnoremap <C-H> <C-W><C-H>
tnoremap <C-J> <C-W><C-J>
tnoremap <C-K> <C-W><C-K>
tnoremap <C-L> <C-W><C-L>

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

let test#strategy = "vimterminal"
let test#python#runner = 'pytest'
let test#python#pytest#options = '-p no:warnings -s'

let test#custom_runners = {'zig': ['ZigTest']}

autocmd FileType cpp let b:dispatch = 'cd build && conan build ..'

map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

let g:slime_target = "vimterminal"

set splitbelow
set splitright
