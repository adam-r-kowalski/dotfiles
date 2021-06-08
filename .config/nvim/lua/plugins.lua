return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall'
  use 'hrsh7th/nvim-compe'
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
  use 'onsails/lspkind-nvim'
  use 'akinsho/nvim-bufferline.lua'
  use 'hoob3rt/lualine.nvim'
  use 'marko-cerovac/material.nvim'
  use 'hrsh7th/vim-vsnip'
end)
