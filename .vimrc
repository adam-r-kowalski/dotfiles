call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-pairs', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-vimlsp', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
Plug 'puremourning/vimspector', {'do': 'python install_gadget.py --all --disable-tcl'}
Plug 'vim-test/vim-test'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'dag/vim-fish'
Plug 'vim-python/python-syntax'
Plug 'psliwka/vim-smoothie'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
Plug 'edkolev/tmuxline.vim'
call plug#end()

set nocompatible

set background=dark
set termguicolors
colorscheme gruvbox

set hidden

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

set laststatus=2

set nobackup
set noswapfile
set noundofile

set nowrap

set noshowmode
set noruler
set laststatus=2

set clipboard^=unnamed,unnamedplus

set tabstop=4 shiftwidth=4 expandtab
autocmd FileType nasm setlocal tabstop=8 shiftwidth=8 expandtab

set number
set relativenumber

set incsearch

set updatetime=300

set shortmess+=c

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

nnoremap <silent> gb <c-o>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
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

let ghregex='\(^\|\s\s\)\zs\.\S\+'
let g:netrw_list_hide=ghregex
let g:netrw_banner = 0

nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
nnoremap <silent> <leader>g  :<C-u>CocList grep<cr>
nnoremap <silent> <Leader>w :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>
nnoremap <leader>f :find 
nnoremap <leader>v :vs **/
nnoremap <leader>h :sp **/
nnoremap <leader>b :b 
nnoremap <silent> <leader>e :Explore<cr>

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

let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'

if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end
