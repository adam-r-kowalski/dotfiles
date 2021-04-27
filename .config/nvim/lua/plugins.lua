return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall'
  use 'nvim-lua/completion-nvim'
  use 'tjdevries/colorbuddy.nvim'
  use 'marko-cerovac/material.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use 'nvim-treesitter/nvim-treesitter'
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use 'tpope/vim-commentary'
  use 'vim-test/vim-test'
  use 'voldikss/vim-floaterm'
  use 'windwp/nvim-autopairs'
  use 'ziglang/zig.vim'
  use {'eraserhd/parinfer-rust', run='cargo build --release'}
  use 'clojure-vim/clojure.vim'
  use 'easymotion/vim-easymotion'
  use 'karb94/neoscroll.nvim'
  use 'glepnir/indent-guides.nvim'
  use 'glepnir/lspsaga.nvim'
  use 'glepnir/galaxyline.nvim'
  use 'onsails/lspkind-nvim'
  use 'akinsho/nvim-bufferline.lua'
end)
