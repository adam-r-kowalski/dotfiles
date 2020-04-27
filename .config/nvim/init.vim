call plug#begin('~/.config/nvim/plugged/')
Plug 'sainnhe/gruvbox-material'
Plug 'itchyny/lightline.vim'
Plug 'georgewitteman/vim-fish'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-pairs', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'weirongxu/coc-explorer', {'do': 'yarn install --frozen-lockfile'}
Plug 'clangd/coc-clangd', {'do': 'yarn install --frozen-lockfile'}
Plug 'voldikss/coc-cmake', {'do': 'yarn install --frozen-lockfile'}
Plug 'puremourning/vimspector'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'ryanoasis/vim-devicons'
call plug#end()

set noshowmode

syntax enable
filetype plugin indent on

autocmd FileType cpp setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType json setlocal expandtab shiftwidth=4 softtabstop=4

set autoindent
set smarttab

set incsearch
set hlsearch

set ruler

set termguicolors

set background=dark
colorscheme gruvbox-material

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'gruvbox_material',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }

set clipboard=unnamed

set hidden

set mouse=a

set nobackup
set nowritebackup

set updatetime=300

set shortmess+=c

set signcolumn=yes

set number
set relativenumber

let g:cpp_concepts_highlight = 1

let mapleader = "\<space>"
let maplocalleader = ","

let g:python3_host_prog = '~/miniconda3/bin/python'

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

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

sign define vimspectorBP text=🔴         texthl=Normal
sign define vimspectorBPCond text=⭕     texthl=Normal
sign define vimspectorBPDisabled text=🔵 texthl=Normal
sign define vimspectorPC text=🔶         texthl=Normal

tnoremap <Esc> <C-\><C-n>

nnoremap <leader>rn <Plug>(coc-rename)
nnoremap <silent> <leader>o :<c-u>CocList outline<cr>
nnoremap <silent> <leader>s :<c-u>CocList -I symbols<cr>
nnoremap <silent> <leader>e :CocCommand explorer<cr>
nnoremap <silent> <leader>f :CocList files<cr>
nnoremap <silent> <leader>g :CocList grep<cr>
nnoremap <silent> <leader>b :CocList buffers<cr>

nnoremap <silent> <localleader>k :VimspectorReset<cr>
nmap <silent> <localleader>p <Plug>VimspectorContinue
nmap <silent> <localleader>t <Plug>VimspectorToggleBreakpoint
nmap <silent> <localleader>c <Plug>VimspectorToggleConditionalBreakpoint
nmap <silent> <localleader>n <Plug>VimspectorStepOver
nmap <silent> <localleader>i <Plug>VimspectorStepInto
nmap <silent> <localleader>o <Plug>VimspectorStepOut
nmap <silent> <localleader>sc :VimspectorShowOutput Console<cr>
nmap <silent> <localleader>st :VimspectorShowOutput Telemetry<cr>
nmap <silent> <localleader>se :VimspectorShowOutput stderr<cr>
nmap <silent> <localleader>ss :VimspectorShowOutput server<cr>
nmap <silent> <localleader>so :VimspectorShowOutput Vimspector-out<cr>
nmap <silent> <localleader>sv :VimspectorShowOutput Vimspector-err<cr>
nmap <localleader>e :VimspectorEval 
nmap <localleader>w :VimspectorWatch 

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

nnoremap <silent> gb <c-o>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> gh :call <SID>show_documentation()<CR>

