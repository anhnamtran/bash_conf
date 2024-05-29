-- Setup for nvim-osc52
-- require('osc52').setup {
--   max_length = 10000,
--   silent = false,
--   trim = true,
-- }
-- Force vim to use OSC52 to copy and paste certain registers
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}
