-- Settings for flash.nvim
require('flash').setup({
  keys = 'abcdefghijklmnop',
  modes = {
    char = {
       enabled = false,
    }
  },
})

function flash_word()
  require("flash").jump({
    pattern = ".", -- initialize pattern with any char
    search = {
      mode = function(pattern)
         return "\\<" .. pattern
      end,
    },
    -- select the range
    jump = { pos = "start" },
  })
end

vim.keymap.set(
  'n',
  '<c-space>',
  function() require('flash').jump() end,
  { noremap = true, silent = true })

vim.keymap.set(
  'n',
  '<leader>w',
  flash_word,
  { noremap = true, silent = true })
