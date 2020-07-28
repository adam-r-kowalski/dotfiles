call plug#begin(stdpath('data') . '/plugged')
Plug 'sainnhe/gruvbox-material'
Plug 'ziglang/zig.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
call plug#end()

let g:coc_global_extensions = [
  \ 'coc-yank',
  \ 'coc-vimlsp',
  \ 'coc-git',
  \ 'coc-explorer',
  \ 'coc-json',
  \ 'coc-fzf-preview',
  \ 'coc-marketplace',
  \ 'coc-python',
  \ 'coc-pairs',
  \ ]

set termguicolors
set background=dark

let g:gruvbox_material_background = 'medium'

colorscheme gruvbox-material

set mouse=a

set clipboard^=unnamed,unnamedplus

set hidden

set number relativenumber

set nobackup nowritebackup

set updatetime=300

set shortmess+=c

set signcolumn=yes

set expandtab shiftwidth=4

nnoremap ; :

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
nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gn <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

let g:mapleader=' '
let g:maplocalleader=' '

nmap <leader>rn <Plug>(coc-rename)

xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>ac <Plug>(coc-codeaction)
nmap <leader>qf <Plug>(coc-fix-current)

xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

nnoremap <silent><nowait> <leader>a :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <leader>o :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <leader>s :<C-u>CocList -I symbols<cr>

nnoremap <Leader>f :<c-u>CocCommand fzf-preview.ProjectFiles<cr>
nnoremap <Leader>g :<c-u>CocCommand fzf-preview.ProjectGrep 
nnoremap <Leader>b :<c-u>CocCommand fzf-preview.Buffers<cr>
nnoremap <leader>e :<c-u>CocCommand explorer<cr>

nnoremap <leader>i :e ~/.config/nvim/init.vim<cr>

inoremap jk <esc>

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
