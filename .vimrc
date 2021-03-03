call plug#begin('~/.vim/plugged')
Plug 'embark-theme/vim', { 'as': 'embark' }
Plug 'ziglang/zig.vim'
Plug 'itchyny/lightline.vim'
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ryanoasis/vim-devicons'
call plug#end()

set termguicolors
set laststatus=2
set noshowmode
set number relativenumber
set mouse=a
set clipboard^=unnamed,unnamedplus
set encoding=utf-8
set hidden
set nobackup nowritebackup
set updatetime=300
set shortmess+=c
set signcolumn=number

let g:mapleader=' '
let g:lightline = {
    \ 'colorscheme': 'embark',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'cocstatus': 'coc#status'
    \ },
    \ }
let g:embark_terminal_italics = 1
let g:coc_global_extensions=['coc-json', 'coc-git', 'coc-explorer', 'coc-vimlsp']

colorscheme embark

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nnoremap ; :
nnoremap <leader>i :e ~/.vimrc<cr>
nnoremap <leader>pi :PlugInstall<cr>
nnoremap <leader>pu :PlugUpdate<cr>
nnoremap <leader>pc :PlugClean<cr>
nnoremap <leader>s :so %<cr>
nnoremap <leader>e :CocCommand explorer<cr>
nmap <leader>rn <plug>(coc-rename)
nmap gp <plug>(coc-diagnostic-prev)
nmap gn <plug>(coc-diagnostic-next)
nmap gd <plug>(coc-definition)
nmap gr <plug>(coc-references)
nnoremap gh :call <sid>show_documentation()<cr>
nnoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<c-f>"
nnoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-b>"
inoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<right>"
inoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<left>"
vnoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<c-f>"
vnoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<c-b>"
inoremap jk <esc>
inoremap <silent><expr> <TAB>
   \ pumvisible() ? "\<C-n>" :
   \ <SID>check_back_space() ? "\<TAB>" :
   \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <cr> pumvisible()
   \? coc#_select_confirm()
   \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
xmap <leader>a <plug>(coc-codeaction-selected)
nmap <leader>a <plug>(coc-codeaction-selected)
nmap <leader>ac <plug>(coc-codeaction)
nmap <leader>qf <plug>(coc-fix-current)
xmap if <plug>(coc-funcobj-i)
omap if <plug>(coc-funcobj-i)
xmap af <plug>(coc-funcobj-a)
omap af <plug>(coc-funcobj-a)
xmap ic <plug>(coc-classobj-i)
omap ic <plug>(coc-classobj-i)
xmap ac <plug>(coc-classobj-a)
omap ac <plug>(coc-classobj-a)

augroup lang_group
  autocmd!
  autocmd BufNewFile,BufRead *.lang set filetype=clojure
augroup end

augroup coc_group
  autocmd!
  autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
  autocmd FileType json syntax match Comment +\/\/.\+$+
augroup end
