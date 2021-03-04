call plug#begin('~/.vim/plugged')
Plug 'ziglang/zig.vim'
Plug 'itchyny/lightline.vim'
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'arcticicestudio/nord-vim'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'voldikss/vim-floaterm'
Plug 'vim-test/vim-test'
Plug 'tpope/vim-commentary'
Plug 'puremourning/vimspector'
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
set expandtab
set noswapfile

colorscheme nord
syntax on

let g:mapleader=' '
let g:lightline = {
    \ 'colorscheme': 'nord',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'cocstatus': 'coc#status'
    \ },
    \ }
let g:embark_terminal_italics = 1
let g:coc_global_extensions=['coc-json', 'coc-git', 'coc-explorer', 'coc-vimlsp', 'coc-fzf-preview']
let g:test#custom_runners = {'zig': ['Zigtest']}
let g:test#strategy = "floaterm"
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
let g:vimspector_install_gadgets = ['CodeLLDB']

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
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <leader>i :e ~/.vimrc<cr>
nnoremap <leader>pi :PlugInstall<cr>
nnoremap <leader>pu :PlugUpdate<cr>
nnoremap <leader>pc :PlugClean<cr>
nnoremap <leader>s :so %<cr>
nnoremap <leader>e :CocCommand explorer<cr>
nnoremap <leader>f :CocCommand fzf-preview.ProjectFiles<cr>
nnoremap <leader>b :CocCommand fzf-preview.Buffers<cr>
nnoremap <leader>g :CocCommand fzf-preview.ProjectGrep 
nnoremap <leader>p :CocCommand fzf-preview.CommandPalette<cr>
nnoremap <leader>tn :TestNearest<cr>
nnoremap <leader>tf :TestFile<cr>
nnoremap <leader>tl :TestLast<cr>
nnoremap <leader>tv :TestVisit<cr>
nnoremap <leader>ts :TestSuite<cr>
nnoremap <leader>v :Git<cr>
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
nnoremap <f2> <cmd>call vimspector#ToggleBreakpoint(
                    \ { 'condition': input( 'Enter condition expression: ' ),
                    \   'hitCondition': input( 'Enter hit count expression: ' ) }
                    \ )<cr>
nnoremap <f3> <cmd>call vimspector#ToggleBreakpoint()<cr>
nnoremap <f4> <cmd>call vimspector#Launch()<cr>
nnoremap <f5> <cmd>call vimspector#Reset()<cr>
nnoremap <f6> <cmd>call vimspector#StepOut()<cr>
nnoremap <f7> <cmd>call vimspector#StepOver()<cr>
nnoremap <f8> <cmd>call vimspector#StepInto()<cr>
nnoremap <f9> <cmd>call vimspector#RunToCursor()<cr>
nnoremap <f10> <cmd>call vimspector#Continue()<cr>

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
