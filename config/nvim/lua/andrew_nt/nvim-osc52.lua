-- Setup for nvim-osc52
require('osc52').setup {
  max_length = 10000,
  silent = true,
  trim = true,
}

function copy()
  if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
    require('osc52').copy_register('c')
  end
end

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup("osc52-au", {}),
  callback = function()
    if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
      require('osc52').copy_register('+')
    end
    if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
      require('osc52').copy_register('*')
    end
  end
})
