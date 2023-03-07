-- Setup for nvim-osc52
require('osc52').setup {
  max_length = 10000,
  silent = false,
  trim = true,
}

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup("osc52-au", {}),
  callback = function()
    if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
      require('osc52').copy_register('+')
    end
  end
})
