call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
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
Plug 'tpope/vim-abolish'
Plug 'dag/vim-fish'
Plug 'vim-python/python-syntax'
Plug 'psliwka/vim-smoothie'
Plug 'jpalardy/vim-slime'
call plug#end()

set nocompatible

set termguicolors
set background=dark
colorscheme nord

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

set noruler
set laststatus=2

set clipboard^=unnamed,unnamedplus

set tabstop=4 shiftwidth=4 expandtab
autocmd FileType nasm setlocal tabstop=8 shiftwidth=8 expandtab

set number
set relativenumber

set hlsearch
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

let test#strategy = "vimterminal"

let ghregex='\(^\|\s\s\)\zs\.\S\+'
let g:netrw_list_hide=ghregex
let g:netrw_banner = 0

set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

command -nargs=+ -complete=file -bar Grep silent! grep! <args>|cwindow|redraw!

nnoremap <Leader>c :cclose<cr>
nnoremap <Leader>w :grep! "\b<c-r><c-w>\b"<cr>:cw<cr>
nnoremap <leader>g :Grep<space>
nnoremap <leader>f :find<space>
nnoremap <leader>v :vs **/
nnoremap <leader>h :sp **/
nnoremap <leader>b :b<space>
nnoremap <leader>e :Explore<cr>

nnoremap <leader>tn :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ts :TestSuite<CR>
nnoremap <leader>tl :TestLast<CR>
nnoremap <leader>tv :TestVisit<CR>

nnoremap <silent> <F2> :VimspectorReset<CR>
let g:vimspector_enable_mappings = 'HUMAN'

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

if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

set ttimeoutlen=100

nnoremap <c-h> <c-w><c-h>
inoremap <c-h> <esc><c-w><c-h>
tnoremap <c-h> <c-\><c-n><c-w><c-h>

nnoremap <c-j> <c-w><c-j>
inoremap <c-j> <esc><c-w><c-j>
tnoremap <c-j> <c-\><c-n><c-w><c-j>

nnoremap <c-k> <c-w><c-k>
inoremap <c-k> <esc><c-w><c-k>
tnoremap <c-k> <c-\><c-n><c-w><c-k>

nnoremap <c-l> <c-w><c-l>
inoremap <c-l> <esc><c-w><c-l>
tnoremap <c-l> <c-\><c-n><c-w><c-l>

let g:slime_target = "vimterminal"
let g:slime_vimterminal_config = {"term_finish": "close"}
let g:slime_no_mappings = 1
let g:slime_python_ipython=1

xmap <localleader>e <Plug>SlimeRegionSend
nmap <localleader>e <Plug>SlimeParagraphSend
nmap <localleader>E <Plug>SlimeConfig

