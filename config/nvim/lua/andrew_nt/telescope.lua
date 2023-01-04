-- Setup for telescope.nvim
require('telescope').setup()
require('telescope').load_extension('fzf')
local builtin = require('telescope.builtin')
vim.keymap.set('n', '_', function() builtin.find_files( { cwd = vim.fn.expand('%:p:h') } ) end, {})
vim.keymap.set('n', '<leader>F', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})

vim.api.nvim_create_user_command("Files",
  function (opts)
    builtin.find_files( { cwd = opts.fargs[1] } )
  end,
  { nargs = 1, complete = "dir" }
)
