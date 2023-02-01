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
      pattern = '/src/(.*)/(.*).h$',
      target = '/src/%1/%2.cpp',
      context = 'Source',
    },
    {
      pattern = '/src/(.*)/(.*).tin$',
      target = '/src/%1/%2.tac',
      context = 'TACC'
    },
    {
       pattern = '/src/(.*)/(.*).tac$',
      target = {
        { target = '/src/%1/%2.tin', context = 'tin' },
        { target = '/src/%1/%2.itin', context = 'itin' },
      }
    },
    {
      pattern = '/src/(.*)/(.*).itin$',
      target = {
        { target = '/src/%1/%2.tin', context = 'tin' },
        { target = '/src/%1/%2.tac', context = 'tac' },
      }
    },
    {
      pattern = '/bld.*/(.*)/(.*).cpp$',
      target = '/bld/%1/%2.h',
      context = 'Header',
    },
    {
      pattern = '/bld.*/(.*)/(.*).h$',
      target = '/bld/%1/%2.cpp',
      context = 'Source',
    },
    {
      pattern = '/bld.*/(.*)/(.*).tin$',
      target = '/bld/%1/%2.tac',
      context = 'TACC'
    },
    {
       pattern = '/bld.*/(.*)/(.*).tac$',
      target = {
        { target = '/bld/%1/%2.tin', context = 'tin' },
        { target = '/bld/%1/%2.itin', context = 'itin' },
      }
    },
    {
      pattern = '/bld.*/(.*)/(.*).itin$',
      target = {
        { target = '/bld/%1/%2.tin', context = 'tin' },
        { target = '/bld/%1/%2.tac', context = 'tac' },
      }
    },
  }
}

vim.keymap.set('n', '<leader>t', ':Other<CR>')
