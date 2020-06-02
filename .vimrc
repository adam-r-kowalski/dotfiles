call plug#begin('~/.vim/plugged')
Plug 'dracula/vim'
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yank', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-pairs', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-snippets' , {'do': 'yarn install --frozen-lockfile'}
Plug 'weirongxu/coc-explorer', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-vimlsp', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
Plug 'ryanoasis/vim-devicons'
Plug 'vim-test/vim-test'
Plug 'puremourning/vimspector'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'dag/vim-fish'
Plug 'vim-python/python-syntax'
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'
call plug#end()

set nocompatible

let g:dracula_italic = 0

set background=dark
set termguicolors
colorscheme dracula


set path+=**

set wildmenu


let g:lightline = {
  \ 'colorscheme': 'dracula',
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'ctrlpmark', 'git', 'diagnostic', 'cocstatus', 'filename', 'method' ]
  \   ],
  \   'right':[
  \     [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
  \     [ 'blame' ]
  \   ],
  \ },
  \ 'component_function': {
  \   'blame': 'LightlineGitBlame',
  \ }
\ }

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  return winwidth(0) > 120 ? blame : ''
endfunction

set hidden

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

set nobackup
set noswapfile
set noundofile

set nowrap

set noshowmode

set cmdheight=1

set clipboard^=unnamed,unnamedplus


set tabstop=4 shiftwidth=4 expandtab
autocmd FileType nasm setlocal tabstop=8 shiftwidth=8 expandtab

set number
set relativenumber

set incsearch

set updatetime=300

set shortmess+=c

set laststatus=2

set mouse=a

set splitbelow
set splitright

set shell=fish

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

inoremap <silent><expr> <c-space> coc#refresh()

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> gb <c-o>
nnoremap <silent> K :call <SID>show_documentation()<CR>


function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

let mapleader = " "
let maplocalleader = ","

nmap <leader>rn <Plug>(coc-rename)

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

command! -nargs=0 Format :call CocAction('format')

function! s:GrepFromSelected(type)
  let saved_unnamed_register = @@
  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif
  let word = substitute(@@, '\n$', '', 'g')
  let word = escape(word, '| ')
  let @@ = saved_unnamed_register
  execute 'CocList grep '.word
endfunction

command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

let test#strategy = "vimterminal"

nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
nnoremap <silent> <leader>f  :Files<cr>
nnoremap <silent> <leader>b  :Buffers<cr>
nnoremap <silent> <leader>g  :<C-u>CocList grep<cr>
vnoremap <silent> <leader>v :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
nnoremap <silent> <leader>v :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@
nnoremap <silent> <Leader>w :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>
nnoremap <silent> <leader>e :CocCommand explorer<cr>

nnoremap <silent> <leader>tn :TestNearest<CR>
nnoremap <silent> <leader>tf :TestFile<CR>
nnoremap <silent> <leader>ts :TestSuite<CR>
nnoremap <silent> <leader>tl :TestLast<CR>
nnoremap <silent> <leader>tv :TestVisit<CR>

nmap <silent> <localleader>n <Plug>VimspectorStepOver
nmap <silent> <localleader>i <Plug>VimspectorStepInto
nmap <silent> <localleader>o <Plug>VimspectorStepOut
nmap <silent> <localleader>p <Plug>VimspectorContinue
nmap <silent> <localleader>b <Plug>VimspectorToggleBreakpoint
nmap <silent> <localleader>c <Plug>VimspectorToggleConditionalBreakpoint
nnoremap <silent> <localleader>k :VimspectorReset<CR>

nnoremap ; :
vnoremap ; :

inoremap jk <esc>

tnoremap jk <c-\><c-n>

nnoremap <c-h> <c-w>h
inoremap <c-h> <esc><c-w>h
tnoremap <c-h> <c-\><c-n><c-w>h

nnoremap <c-j> <c-w>j
inoremap <c-j> <esc><c-w>j
tnoremap <c-j> <c-\><c-n><c-w>j

nnoremap <c-k> <c-w>k
inoremap <c-k> <esc><c-w>k
tnoremap <c-k> <c-\><c-n><c-w>k

nnoremap <c-l> <c-w>l
inoremap <c-l> <esc><c-w>l
tnoremap <c-k> <c-\><c-n><c-w>k

let g:sneak#label = 1
let g:sneak#s_next = 1

map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

let g:python_highlight_all = 1

let g:asmsyntax = 'nasm'

let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]
