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
      for index, value in ipairs(excluded_filetypes) do
        if value == filetype then
          return false
        end
      end
      return true
    end,
    extended_mode = true,
    max_file_lines = 1000000,
  },
  -- Requires nvim-treesitter/playground
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldenable = false
