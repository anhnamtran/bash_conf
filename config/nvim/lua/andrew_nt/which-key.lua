-- Settings for which-key.nvim
require('which-key').setup({
  preset = "helix",
})

vim.keymap.set(
  'n',
  '<leader>?',
  function() require('which-key').show({ global = false }) end,
  { noremap = true, silent = true })
