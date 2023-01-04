-- This file can be loaded by calling `lua require('plugins')` from init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[
packadd packer.nvim
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- nvim companion plugins
  use {
    'nvim-lua/plenary.nvim',
    config = function()
      require('plenary.filetype').add_file('tin')
      require('plenary.filetype').add_file('qb')
    end
  }
  use 'nvim-lua/popup.nvim'

  -- Themes
  use {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').load()
    end
  }

  -- GUIs elements
  use 'nvim-lualine/lualine.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use {
    'lewis6991/gitsigns.nvim',
    config = function ()
      require('gitsigns').setup()
    end
  }
  use 'mhinz/vim-startify'
  use 'lukas-reineke/indent-blankline.nvim'

  -- Syntax handling
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'p00f/nvim-ts-rainbow',
    requires = { 'nvim-treesitter/nvim-treesitter' }
  }
  use { 'neoclide/coc.nvim', branch = 'release', run = ':CocUpdate' }

  -- System navigation
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = [[cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release \
              && cmake --build build --config Release \
              && cmake --install build --prefix build]]
  }
  use 'alexghergh/nvim-tmux-navigation'
  use {
    'preservim/nerdtree',
    opt = true,
    cmd = { 'NERDTreeToggle' },
    config = function ()
      vim.g.NERDTreeSortHiddenFirst = 1
      vim.g.NERDTreeQuitOnOpen = 1
    end
  }
  use {
    'Xuyuanp/nerdtree-git-plugin',
    opt = true,
    cmd = { 'NERDTreeToggle' },
    requires = { 'preservim/nerdtree' }
  }

  -- Session tracking
  use 'tpope/vim-obsession'

  -- Utility
  use 'rgroli/other.nvim'
  use 'tpope/vim-fugitive'
  use {
    'sindrets/diffview.nvim',
    config = function ()
      require('diffview').setup()
    end
  }
  use {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end
  }
  use 'tpope/vim-commentary'
  use {
    'tpope/vim-eunuch',
    config = function()
      vim.g.eunuch_no_maps = 1
    end
  }
  use 'szw/vim-maximizer'
  use 'inkarkat/vim-ingo-library'
  use {
    'inkarkat/vim-mark',
    config = function()
      vim.g.mwDefaultHighlightingPalette = 'maximum'
    end,
    requires = { 'inkarkat/vim-ingo-library' },
  }
  use 'windwp/nvim-autopairs'
  use 'easymotion/vim-easymotion'
  use 'karb94/neoscroll.nvim'
  use 'lewis6991/impatient.nvim'
  use 'ojroques/nvim-osc52'

  -- Arista specific plugins
  use 'https://gitlab.aristanetworks.com/vim-scripts/mts.vim'
  use 'https://gitlab.aristanetworks.com/vim-scripts/bug.vim'
end)
