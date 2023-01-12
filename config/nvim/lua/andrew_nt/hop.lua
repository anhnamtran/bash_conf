-- Setup for hop.nvim
local hop = require('hop')
local directions = require('hop.hint').HintDirection
local function nmap(shortcut, command, noremap)
  vim.keymap.set('n', shortcut, command, { noremap = noremap, silent = true })
end

hop.setup({
  keys = 'abcdefghijklmnop'
})

nmap('f',
  function()
    hop.hint_char1({
      direction = directions.AFTER_CURSOR,
      current_line_only = true,
    })
  end,
  true
)

nmap('F',
  function()
    hop.hint_char1({
      direction = directions.BEFORE_CURSOR,
      current_line_only = true,
    })
  end,
  true
)

nmap('t',
  function()
    hop.hint_char1({
      direction = directions.AFTER_CURSOR,
      current_line_only = true,
      hint_offset = -1
    })
  end,
  true
)

nmap('T',
  function()
    hop.hint_char1({
      direction = directions.BEFORE_CURSOR,
      current_line_only = true,
      hint_offset = 1,
    })
  end,
  true
)

nmap('<leader>w',
  function()
    hop.hint_words({
      direction = directions.AFTER_CURSOR,
    })
  end,
  true
)
