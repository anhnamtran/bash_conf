-- Setup for other.nvim
require('other-nvim').setup {
  -- Don't remember the selection for the current user session
  rememberBuffers = false,

  -- change the style to fit more with the theme of my neovim
  style = {
    border = 'single',
  },

  -- mappings
  mappings = {
    {
      pattern = '/src/(.*)/(.*).cpp$',
      target = '/src/%1/%2.h',
      context = 'Header',
    },
    {
      pattern = '/src/(.*)/(.*).cpp$',
      target = '/include/%1/%2.hpp',
      context = 'Header',
    },
    {
      pattern = '/src/(.*)/(.*).h$',
      target = '/src/%1/%2.cpp',
      context = 'Source',
    },
    {
      pattern = '/include/(.*)/(.*).hpp$',
      target = '/src/%1/%2.cpp',
      context = 'Source',
    },
  }
}

vim.keymap.set('n', '<leader>t', ':Other<CR>')
