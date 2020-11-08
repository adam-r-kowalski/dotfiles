call plug#begin(stdpath('data') . '/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dracula/vim', {'name': 'dracula'}
Plug 'vim-airline/vim-airline'
Plug 'ziglang/zig.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'luochen1990/rainbow'
Plug 'vim-test/vim-test'
Plug 'tpope/vim-repeat'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'dag/vim-fish'
Plug 'ryanoasis/vim-devicons'
call plug#end()

let g:coc_global_extensions = [
  \'coc-json',
  \'coc-pyright',
  \'coc-pairs',
  \'coc-explorer',
  \'coc-fzf-preview',
  \'coc-highlight',
  \]

set termguicolors
set background=dark
colorscheme dracula

set hidden

set nobackup nowritebackup

set updatetime=300

set shortmess+=c

let g:airline_powerline_fonts = 1

set clipboard^=unnamed,unnamedplus

set number relativenumber

set splitright splitbelow

let g:mapleader=' '

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
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

let g:rainbow_active = 1

set inccommand=nosplit

let test#strategy = "neovim"
let test#python#pytest#options = '-s'
let test#custom_runners = {'zig': ['zigtest']}

let g:asmsyntax = 'nasm'

let g:fzf_preview_if_binary_command = "string match 'binary' (file --mime {})"

set mouse=a

set expandtab shiftwidth=4

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

inoremap jk <esc>
tnoremap jk <c-\><c-n>

nnoremap ; :

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> gb <c-o>
nnoremap <silent> gh :call <SID>show_documentation()<CR>

nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

nmap <silent> <leader>dp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>dn <Plug>(coc-diagnostic-next)
nnoremap <leader>i :e ~/.config/nvim/init.vim<cr>
nnoremap <leader>I :so %<cr>
nnoremap <leader>e :CocCommand explorer<cr>
nnoremap <leader>v :Git<cr>
nnoremap <leader>f :CocCommand fzf-preview.ProjectFiles<cr>
nnoremap <leader>g :CocCommand fzf-preview.ProjectGrep 
nnoremap <leader>b :CocCommand fzf-preview.Buffers<cr>
nnoremap <leader>tn :TestNearest<cr>
nnoremap <leader>tf :TestFile<cr>
nnoremap <leader>tl :TestLast<cr>
nnoremap <leader>ts :TestSuite<cr>
nnoremap <leader>tv :TestVisit<cr>

nmap s <Plug>(easymotion-overwin-f2)
