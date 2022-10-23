-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Colorscheme
  use 'EdenEast/nightfox.nvim'

  -- Coc
  use {
    'neoclide/coc.nvim', branch = 'release'
  }

  -- Syntax highlighting
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }
  use 'windwp/nvim-ts-autotag'

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- Auto pairs
  use 'windwp/nvim-autopairs'

  -- File navigation
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  -- Colorize CSS colors
  use 'norcalli/nvim-colorizer.lua'

  -- Autocommenting
  use 'tpope/vim-commentary'
end)
