-- This file can be loaded by calling `lua require('plugins')` from init.vim

-- Only required if you have packer configured as `opt`
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- nvim companion plugins
  'nvim-lua/plenary.nvim',
  'nvim-lua/popup.nvim',

  -- Themes
  'navarasu/onedark.nvim',

  -- GUIs elements
  'nvim-lualine/lualine.nvim',
  'kyazdani42/nvim-web-devicons',
  'lewis6991/gitsigns.nvim',
  'mhinz/vim-startify',
  'lukas-reineke/indent-blankline.nvim',
  'rcarriga/nvim-notify',

  -- Syntax handling
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'nvim-treesitter/playground',
    dependencies = { 'nvim-treesitter/nvim-treesitter' } },
  { 'mrjones2014/nvim-ts-rainbow',
    dependencies = { 'nvim-treesitter/nvim-treesitter' } },
  { 'neoclide/coc.nvim', branch = 'release', build = ':CocUpdate' },

  -- System navigation
  { 'nvim-telescope/telescope.nvim', branch = 'master',
    dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'fannheyward/telescope-coc.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' } },
  'alexghergh/nvim-tmux-navigation',
  { 'preservim/nerdtree',
    lazy = true,
    cmd = { 'NERDTreeToggle' },
    config = function ()
      vim.g.NERDTreeSortHiddenFirst = 1
      vim.g.NERDTreeQuitOnOpen = 1
    end
  },
  { 'Xuyuanp/nerdtree-git-plugin',
    lazy = true,
    cmd = { 'NERDTreeToggle' },
    dependencies = { 'preservim/nerdtree' } },
  { 'godlygeek/tabular' },
  { 'preservim/vim-markdown' },

  -- Session tracking
  'tpope/vim-obsession',

  -- Utility
  'rgroli/other.nvim',
  'tpope/vim-fugitive',
  'rbong/vim-flog',
  { 'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end },
  'tpope/vim-commentary',
  { 'tpope/vim-eunuch',
    config = function()
      vim.g.eunuch_no_maps = 1
    end },
  'szw/vim-maximizer',
  'inkarkat/vim-ingo-library',
  { 'inkarkat/vim-mark',
    config = function()
      vim.g.mwDefaultHighlightingPalette = 'maximum'
    end,
    dependencies = { 'inkarkat/vim-ingo-library' } },
  'windwp/nvim-autopairs',
  { 'NAndLib/hop.nvim', branch = 'master' },
  'karb94/neoscroll.nvim',
  'ojroques/nvim-osc52',
  { 'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end },

  { 'sakhnik/nvim-gdb', build = './install.sh' },
  { 'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    event = {
      "BufReadPre " .. vim.fn.expand( "~") .. "/obsidian/Primary/**.md",
      "BufNewFile " .. vim.fn.expand( "~") .. "/obsidian/Primary/**.md"
    },
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { 'moll/vim-bbye' },
  { 'aymericbeaumet/vim-symlink', dependencies = { 'moll/vim-bbye' } },
}, {
  ui = {
    border = 'rounded'
  }
})
