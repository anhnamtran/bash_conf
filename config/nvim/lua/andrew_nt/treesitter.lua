-- Setup for treesitter and treesitter related plugins
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'cpp', 'bash', 'vim', 'json', 'python', 'go', 'comment', 'rust' },
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  -- Requires nvim-ts-rainbow
  rainbow = {
    enable = function()
      local excluded_filetypes = { 'log', 'qt', 'wiki' }
      local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
      return excluded_filetypes[filetype] == nil
    end,
    extended_mode = true,
    max_file_lines = 1000000,
  }
}
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = false
