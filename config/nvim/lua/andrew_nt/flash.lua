-- Settings for flash.nvim
require('flash').setup({
  keys = 'abcdefghijklmnop',
  search = {
    incremental = true,
  },
  modes = {
    char = {
       enabled = false,
    }
  },
})

vim.keymap.set(
  'n',
  '<c-space>',
  function() require('flash').jump() end,
  { noremap = true, silent = true })
