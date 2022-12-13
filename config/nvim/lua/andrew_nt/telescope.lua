-- Setup for telescope.nvim
require('telescope').setup()
local builtin = require('telescope.builtin')
vim.keymap.set('n', '_', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
