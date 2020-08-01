call plug#begin(stdpath('data') . '/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'ziglang/zig.vim'
Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

colorscheme nord

let g:airline_powerline_fonts = 1

set clipboard^=unnamed,unnamedplus

set number relativenumber

let g:mapleader=' '

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

autocmd BufEnter * lua require'completion'.on_attach()
autocmd BufEnter * lua require'diagnostic'.on_attach()

set completeopt=menuone,noinsert,noselect

set shortmess+=c

let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_virtual_text_prefix = ' '

set signcolumn=yes

inoremap jk <esc>

nnoremap ; :

inoremap <c-h> <esc><c-w>h
nnoremap <c-h> <c-w>h

inoremap <c-j> <esc><c-w>j
nnoremap <c-j> <c-w>j

inoremap <c-k> <esc><c-w>k
nnoremap <c-k> <c-w>k

inoremap <c-l> <esc><c-w>l
nnoremap <c-l> <c-w>l

nnoremap <leader>i :e ~/.config/nvim/init.vim<cr>
nnoremap <leader>I :so %<cr>

nnoremap <leader>f :Files<cr>
nnoremap <leader>g :Rg<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>p :Commands<cr>

nnoremap <silent> gb <c-o>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gH <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gt <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gs <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gS <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

lua << EOF
    local nvim_lsp = require'nvim_lsp'
    
    nvim_lsp.zls.setup{}
    nvim_lsp.pyls.setup{}
    nvim_lsp.vimls.setup{}
EOF
