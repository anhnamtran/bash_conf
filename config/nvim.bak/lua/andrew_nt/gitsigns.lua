-- Setup for gitsigns
require('gitsigns').setup({
  watch_gitdir = {
    interval = 500,
  },
  on_attach = function(bufnr)
    -- Setup keymaps
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']c',
      '<cmd>lua require("gitsigns").next_hunk({ wrap = true, navigation_message = true })<CR>',
      { noremap = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[c',
      '<cmd>lua require("gitsigns").prev_hunk({ wrap = true, navigation_message = true })<CR>',
      { noremap = true })
  end
})
