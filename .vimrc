call plug#begin('~/.vim/plugged/')
Plug 'challenger-deep-theme/vim'
Plug 'vim-test/vim-test'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ycm-core/YouCompleteMe', { 'do': 'python install.py --all' }
Plug 'puremourning/vimspector', { 'do': 'python install_gadget.py --all --disable-tcl' }
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'itchyny/lightline.vim'
call plug#end()

syntax enable
set termguicolors
set background=dark
colorscheme challenger_deep

set number relativenumber

set nobackup nowritebackup noswapfile

set hidden
set mouse=a
set clipboard^=unnamed,unnamedplus

set splitbelow splitright

set noshowmode
set signcolumn=yes
set laststatus=2

set expandtab tabstop=4 shiftwidth=4 softtabstop=4

let mapleader = "\<space>"
let maplocalleader = ","

let test#strategy = "vimterminal"
let test#python#runner = 'pytest'
let test#python#pytest#options = '-p no:warnings'

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0

let g:cpp_concepts_highlight = 1

let g:lightline = {
      \ 'colorscheme': 'challenger_deep',
      \ }

let g:fzf_preview_window = ''

autocmd Filetype cpp setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType cpp let b:dispatch = 'cd build && conan build ..'
autocmd FileType cpp
    \ autocmd BufWritePre <buffer> :YcmCompleter Format

noremap ; :
noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l
inoremap <c-h> <esc><c-w>h
inoremap <c-j> <esc><c-w>j
inoremap <c-k> <esc><c-w>k
inoremap <c-l> <esc><c-w>l
inoremap jk <esc>
tnoremap jk <C-\><C-n>
tnoremap <Esc> <C-\><C-n>
nnoremap <leader>tn :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ts :TestSuite<CR>
nnoremap <leader>tl :TestLast<CR>
nnoremap <leader>tv :TestVisit<CR>
nnoremap <leader>d :Dispatch<CR>
nnoremap <leader>D :Focus 
nnoremap <leader>f :GFiles<cr>
nnoremap <leader>F :Files<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>g :Rg<cr>
nnoremap <leader>v :vsplit $MYVIMRC<cr>
nnoremap <leader>s :source $MYVIMRC<cr>
nnoremap <leader>qc :cclose<cr>
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>E :NERDTreeFind<CR>
nnoremap gd :YcmCompleter GoToDefinition<cr>
nnoremap gi :YcmCompleter GoToInclude<cr>
nnoremap gl :YcmCompleter GoToDeclaration<cr>
nnoremap gr :YcmCompleter GoToReferences<cr>
nnoremap gt :YcmCompleter GetType<cr>
nnoremap gp :YcmCompleter GetParent<cr>
nnoremap gh :YcmCompleter GetDoc<cr>
nnoremap gb <c-o>
nnoremap <localleader>f :YcmCompleter FixIt<cr>
nnoremap <localleader>r :YcmCompleter RefactorRename 
nnoremap <localleader>k :VimspectorReset<cr>
nmap <localleader>p <Plug>VimspectorContinue
nmap <localleader>n <Plug>VimspectorStepOver
nmap <localleader>i <Plug>VimspectorStepInto
nmap <localleader>o <Plug>VimspectorStepOut
nmap <localleader>c <Plug>VimspectorToggleConditionalBreakpoint
nmap <localleader>t <Plug>VimspectorToggleBreakpoint
nmap [ <Plug>VimspectorStepOver
nmap ] <Plug>VimspectorStepInto
nmap \ <Plug>VimspectorStepOut
