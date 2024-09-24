-- Setup for telescope.nvim
require('telescope').setup({
  pickers = {
    buffers = {
      mappings = { i = { ["<CR>"] = require('telescope.actions').select_drop } }
    },
    builtin = {
      tags = {
        push_cursor_on_edit = true,
        push_tagstack_on_edit = true
      }
    }
  },
  extensions = {
    coc = {
      prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
    }
  }
})

require('telescope').load_extension('coc')
require('telescope').load_extension('fzf')

-- Configuration for built-ins
local builtin = require('telescope.builtin')
vim.keymap.set('n', '_', function() builtin.find_files( { cwd = vim.fn.expand('%:p:h') } ) end, {})
vim.keymap.set('n', '<leader>F', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', function() builtin.buffers( { ignore_current_buffer = true, sort_lastused = true } ) end, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, {})

vim.api.nvim_create_user_command("Files",
  function (opts)
    builtin.find_files( { cwd = opts.fargs[1] } )
  end,
  { nargs = 1, complete = "dir" }
)

vim.api.nvim_create_user_command("Tags",
  function (opts)
    builtin.tags( {} )
  end,
  { nargs = 0 }
)

-- Configuration for extensions
local extensions = require('telescope').extensions

vim.api.nvim_create_user_command("Symbols",
  function (opts)
    extensions.coc.workspace_symbols(opts)
  end,
  { nargs = 0 }
)
