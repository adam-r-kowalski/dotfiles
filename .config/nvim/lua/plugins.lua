return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/completion-nvim'
  use 'arcticicestudio/nord-vim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  } 
  use 'kyazdani42/nvim-web-devicons'
  use 'hoob3rt/lualine.nvim'
  use 'tpope/vim-commentary'
  use 'vim-test/vim-test'
  use 'voldikss/vim-floaterm'
  use 'windwp/nvim-autopairs'
  use 'ziglang/zig.vim'
  use {'eraserhd/parinfer-rust', run='cargo build --release'}
  use 'clojure-vim/clojure.vim'
end)
